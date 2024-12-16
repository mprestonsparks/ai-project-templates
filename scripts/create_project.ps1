# Script to create GitHub Project programmatically
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectTitle,
    
    [Parameter(Mandatory=$false)]
    [string[]]$Repositories = @()
)

# Function to check if token has required scopes
function Test-GitHubScopes {
    $requiredScopes = @('project', 'read:project')
    
    try {
        # Get current token scopes using the API
        $authStatus = gh api user | ConvertFrom-Json
        if (-not $authStatus) {
            Write-Error "Not logged in to GitHub. Please run 'gh auth login' first."
            return $false
        }
        
        # Get token scopes from auth status
        $authOutput = gh auth status 2>&1 | Out-String
        
        # Parse scopes from the output
        $tokenScopes = @()
        if ($authOutput -match "Token scopes: '([^']+(?:',\s*'[^']+)*)'") {
            $scopeString = $Matches[1]
            $tokenScopes = $scopeString -split "',\s*'" | ForEach-Object { $_.Trim("' ") }
        }
        elseif ($authOutput -match "OAuth scopes: (.+)") {
            $tokenScopes = $Matches[1].Split(',').Trim()
        }
        else {
            Write-Error "Could not parse GitHub token scopes"
            return $false
        }
        
        if (-not $tokenScopes) {
            Write-Error "No scopes found in GitHub token"
            return $false
        }
        
        $missingScopes = $requiredScopes | Where-Object { $_ -notin $tokenScopes }
        
        if ($missingScopes) {
            Write-Host "Missing required GitHub token scopes: $($missingScopes -join ', ')"
            Write-Host @"

To add the required scopes, run:
    gh auth refresh -s $($requiredScopes -join ' -s ')

This will:
1. Open your browser to GitHub
2. Ask you to authorize the new scopes
3. Update your token automatically

Note: This is a one-time setup per machine.
See docs/setup.md for more information.
"@
            return $false
        }
        return $true
    }
    catch {
        Write-Error "Error checking GitHub token scopes: $_"
        return $false
    }
}

# Check for required scopes before proceeding
if (-not (Test-GitHubScopes)) {
    exit 1
}

# Get user info
$userInfo = gh api user | ConvertFrom-Json
$login = $userInfo.login

# Create project using GraphQL API
$createProjectQuery = 'mutation CreateProject($title: String!, $ownerId: ID!) { createProjectV2(input: {title: $title, ownerId: $ownerId}) { projectV2 { id number } } }'

$projectInfo = gh api graphql -f query="$createProjectQuery" -f title="$ProjectTitle" -f ownerId="$($userInfo.node_id)"
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create project"
    exit 1
}

$projectData = $projectInfo | ConvertFrom-Json
$projectId = $projectData.data.createProjectV2.projectV2.id
$projectNumber = $projectData.data.createProjectV2.projectV2.number

Write-Host "Created project #$projectNumber"

# Create status field
$createFieldQuery = 'mutation CreateField($projectId: ID!, $name: String!) { createProjectV2Field(input: {projectId: $projectId, dataType: SINGLE_SELECT, name: $name, options: ["Ready", "In Progress", "Blocked", "Review", "Completed"]}) { projectV2Field { id } } }'

$fieldInfo = gh api graphql -f query="$createFieldQuery" -f projectId="$projectId" -f name="Status"
if ($LASTEXITCODE -eq 0) {
    Write-Host "Created Status field"
}

# Link repositories if provided
foreach ($repo in $Repositories) {
    $repoInfo = gh api repos/$login/$repo | ConvertFrom-Json
    $linkQuery = 'mutation LinkRepo($projectId: ID!, $repoId: ID!) { linkProjectV2ToRepository(input: {projectId: $projectId, repositoryId: $repoId}) { repository { id } } }'

    $linkResult = gh api graphql -f query="$linkQuery" -f projectId="$projectId" -f repoId="$($repoInfo.node_id)"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Linked repository: $repo"
    }
}

Write-Host @"
Project setup complete!
Project URL: https://github.com/users/$login/projects/$projectNumber

Next steps:
1. Visit the project URL to configure view settings
2. Add additional custom fields if needed
3. Configure automation rules for status updates
See docs/customization.md for more information.
"@
