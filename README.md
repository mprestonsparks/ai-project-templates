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

