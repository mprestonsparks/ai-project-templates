# Project Task Management Template

This template provides a comprehensive task management system that integrates with GitHub Issues and Project Boards, designed for AI-assisted development workflows.

## Components

1. `DEVELOPMENT_STATUS.yaml` - Single source of truth for:
   - Current phase and milestone tracking
   - Task dependencies and priorities
   - Development rules
   - Task status definitions
   - AI activity logging

2. `scripts/` - Automation tools for:
   - Setting up GitHub integration
   - Updating task statuses
   - Managing dependencies

3. `docs/` - Detailed documentation for:
   - System setup
   - Workflow guidelines
   - Integration instructions
   - Customization guide

## Project Structure

All project management and AI-related files should be organized in a `.project` directory:

```plaintext
repository/
├── .project/                    # Hidden directory for project management
│   ├── status/                 # Status tracking
│   │   ├── DEVELOPMENT_STATUS.yaml
│   │   └── ai_activity_log.yaml
│   ├── scripts/               # Automation scripts
│   │   ├── setup.sh
│   │   ├── github_setup.sh
│   │   └── update_status.sh
│   └── docs/                  # Project documentation
│       ├── ai_integration.md
│       ├── workflow.md
│       ├── setup.md
│       └── customization.md
├── src/                        # Project source code
├── tests/                      # Project tests
├── README.md                   # Main project documentation
└── .gitignore                 # Git ignore file
```:

This structure:
- Keeps project management files separate from project code
- Provides consistent location for AI-related files
- Follows Unix convention of using dot-directories for configuration
- Makes files easy to reference in Workspace AI Rules
- Can be filtered in code searches and statistics

## Quick Start

1. Copy this template to your project
2. Run the setup script:
   ```bash
   ./scripts/setup.sh
   ```
3. Customize `DEVELOPMENT_STATUS.yaml` for your project
4. Initialize GitHub integration:
   ```bash
   ./scripts/github_setup.sh
   ```

## For AI Assistants

If you're an AI assistant implementing this system:

1. Read `docs/ai_integration.md` for implementation details
2. Follow the workflow in `docs/workflow.md`
3. Use `scripts/update_status.sh` for task updates
4. Monitor `DEVELOPMENT_STATUS.yaml` for changes

## Directory Structure

```
template/
├── DEVELOPMENT_STATUS.yaml
├── scripts/
│   ├── setup.sh
│   ├── github_setup.sh
│   └── update_status.sh
├── docs/
│   ├── setup.md
│   ├── workflow.md
│   ├── ai_integration.md
│   └── customization.md
└── README.md
```

