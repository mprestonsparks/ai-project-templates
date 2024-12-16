#!/bin/bash

# GitHub integration setup script
# Creates labels and configures project board

echo "Setting up GitHub integration..."

# Create status labels
declare -A labels=(
    ["ready"]="0E8A16:Task is ready to be worked on"
    ["in-progress"]="FFA500:Task is currently being worked on"
    ["blocked"]="D93F0B:Task is blocked by dependencies"
    ["review"]="1D76DB:Task is awaiting review"
    ["completed"]="0E8A16:Task is completed"
)

for label in "${!labels[@]}"; do
    IFS=':' read -r color description <<< "${labels[$label]}"
    gh label create "$label" --color "$color" --description "$description" || \
    echo "Label already exists: $label"
done

# Create initial issues from DEVELOPMENT_STATUS.yaml
if [ -f ".project/status/DEVELOPMENT_STATUS.yaml" ]; then
    # Python script to create issues and update YAML
    python3 - << 'EOF'
import yaml
import subprocess
import re

def create_github_issue(task):
    title = f'Task {task["id"]}: {task["name"]}'
    body = f"""
Priority: {task["priority"]}
Status: {task["status"]}
Blocking: {", ".join(map(str, task["blocking"]))}
Prerequisites met: {task["prerequisites_met"]}
"""
    result = subprocess.run(['gh', 'issue', 'create', '--title', title, '--body', body], 
                          capture_output=True, text=True)
    if result.returncode == 0:
        # Extract issue number from URL
        match = re.search(r'/(\d+)$', result.stdout.strip())
        if match:
            return int(match.group(1))
    return None

# Load YAML
with open('.project/status/DEVELOPMENT_STATUS.yaml', 'r') as f:
    status = yaml.safe_load(f)
    modified = False

    # Create issues for tasks without GitHub issues
    for task in status['next_available_tasks']:
        if 'github_issue' not in task or not task['github_issue']:
            issue_number = create_github_issue(task)
            if issue_number:
                print(f'Created issue: Task {task["id"]}: {task["name"]}')
                task['github_issue'] = issue_number
                modified = True

    # Save updated YAML if modified
    if modified:
        with open('.project/status/DEVELOPMENT_STATUS.yaml', 'w') as f:
            yaml.dump(status, f, default_flow_style=False, sort_keys=False)
        print('Updated DEVELOPMENT_STATUS.yaml with issue numbers')
EOF
fi

echo "GitHub integration setup complete!"
echo "Next steps:"
echo "1. Configure project board columns"
echo "2. Link issues to project board"
echo "3. Start managing tasks"
