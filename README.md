# Project Task Management Template

This template provides a comprehensive task management system that integrates with GitHub Issues and Project Boards, designed for AI-assisted development workflows.

## Platform Support

| Feature | Windows | macOS/Linux |
|---------|---------|-------------|
| Project Creation | ✅ (PowerShell) | ❌ Not yet supported |
| GitHub Integration | ✅ (PowerShell/WSL) | ✅ (Shell) |
| Status Updates | ✅ (PowerShell/WSL) | ✅ (Shell) |

See [Setup Guide](docs/setup.md) for detailed platform support information.

## Components

1. `DEVELOPMENT_STATUS.yaml` - Single source of truth for:
   - Current phase and milestone tracking
   - Task dependencies and priorities
   - Development rules
   - Task status definitions
   - AI activity logging

2. `scripts/` - Automation tools for:
   - Setting up GitHub integration (`github_setup.sh`)
   - Creating project boards (`create_project.ps1`, Windows only)
   - Updating task statuses (`update_status.sh`)
   - Managing dependencies

3. `docs/` - Detailed documentation for:
   - System setup (`setup.md`)
   - Workflow guidelines (`workflow.md`)
   - Integration instructions (`ai_integration.md`)
   - Customization guide (`customization.md`)

## Quick Start

1. **Prerequisites**
   - GitHub CLI installed and authenticated
   - Required token scopes (see `docs/setup.md`)
   - Windows PowerShell for full functionality

2. **Installation**
   ```bash
   git clone https://github.com/yourusername/ai-project-templates.git
   cd ai-project-templates
   ```

3. **Create Project** (Windows only)
   ```powershell
   ./scripts/create_project.ps1 -ProjectTitle "Your Project Title"
   ```

4. **Setup GitHub Integration**
   ```bash
   # Windows (PowerShell/WSL) or Linux/Mac
   ./scripts/github_setup.sh
   ```

For detailed setup instructions and customization options, see:
- [Setup Guide](docs/setup.md)
- [Customization Guide](docs/customization.md)

## Project Structure

All project management and AI-related files should be organized in a `.project` directory:

```plaintext
repository/
├── .project/                    # Hidden directory for project management
│   ├── status/                 # Status tracking
│   │   ├── DEVELOPMENT_STATUS.yaml
│   │   └── ai_activity_log.yaml
│   ├── scripts/               # Automation scripts
│   │   ├── setup.sh          # Basic setup (all platforms)
│   │   ├── github_setup.sh   # GitHub integration (all platforms)
│   │   ├── create_project.ps1 # Project creation (Windows only)
│   │   └── update_status.sh  # Status updates (all platforms)
│   └── docs/                  # Project documentation
│       ├── ai_integration.md
│       ├── workflow.md
│       ├── setup.md          # Includes platform support details
│       └── customization.md
├── src/                        # Project source code
├── tests/                      # Project tests
├── README.md                   # Main project documentation
└── .gitignore                 # Git ignore file
```

This structure:
- Keeps project management files separate from project code
- Provides clear organization for AI-related components
- Makes it easy to find documentation and scripts

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
