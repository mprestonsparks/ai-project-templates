# Setup Guide

## Platform Support

Current platform support status:

| Feature | Windows | macOS/Linux |
|---------|---------|-------------|
| Project Creation | ✅ (PowerShell) | ❌ Not yet supported |
| GitHub Integration | ✅ (PowerShell/WSL) | ✅ (Shell) |
| Status Updates | ✅ (PowerShell/WSL) | ✅ (Shell) |

**Note**: While some shell scripts are provided, they have not been extensively tested on macOS/Linux. Primary development and testing is currently done on Windows.

## Prerequisites

1. **GitHub CLI**
   - Install the GitHub CLI (`gh`) from: https://cli.github.com/
   - Run `gh auth login` to authenticate

2. **Required GitHub Token Scopes**
   The following scopes are required for full functionality:
   - `project` - For creating and managing projects
   - `read:project` - For reading project data
   - `repo` - For repository access
   - `workflow` - For GitHub Actions integration

   To add missing scopes, run:
   ```powershell
   gh auth refresh -s project -s read:project
   ```

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/ai-project-templates.git
   cd ai-project-templates
   ```

2. Run the setup script:
   ```bash
   # On Windows (PowerShell):
   ./scripts/setup.ps1

   # On Linux/Mac (limited support):
   ./scripts/setup.sh
   ```

## Project Creation

1. Create a new GitHub Project (Windows only):
   ```powershell
   ./scripts/create_project.ps1 -ProjectTitle "Your Project Title"
   ```

   **Note**: Project creation on macOS/Linux is not yet supported. Use the GitHub web interface instead.

2. The script will:
   - Create a new project board
   - Add a Status field with predefined options
   - Provide a URL to configure the project

3. After creation:
   - Visit the project URL
   - Configure view settings
   - Add additional custom fields if needed
   - Set up automation rules

## GitHub Integration

1. Set up GitHub integration:
   ```bash
   # On Windows (PowerShell/WSL):
   ./scripts/github_setup.sh

   # On Linux/Mac:
   ./scripts/github_setup.sh
   ```

2. This will:
   - Create status labels
   - Configure project board
   - Link existing issues

## Customization

See [customization.md](customization.md) for:
- Adding custom fields
- Modifying status options
- Setting up automation rules
- Integrating with other tools

## Known Limitations

1. **Windows-Only Features**:
   - Project creation script (`create_project.ps1`)
   - Some PowerShell-specific functionality

2. **Limited macOS/Linux Support**:
   - Basic shell scripts work but are not extensively tested
   - No native project creation script
   - Some features may require manual setup

3. **Future Plans**:
   - Add native macOS/Linux support for project creation
   - Improve cross-platform compatibility
   - Add platform-specific installation guides
