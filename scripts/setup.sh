#!/bin/bash

# Project setup script
# This script initializes the task management system

echo "Setting up task management system..."

# Check prerequisites
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI not found. Please install it first."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "Git not found. Please install it first."
    exit 1
fi

# Check Python and required packages
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Install PyYAML if not present
if ! python3 -c "import yaml" &> /dev/null; then
    echo "Installing PyYAML..."
    python3 -m pip install PyYAML
fi

# Initialize directory structure
mkdir -p .github/workflows

# Copy template files
cp template/DEVELOPMENT_STATUS.yaml ./DEVELOPMENT_STATUS.yaml
echo "Created DEVELOPMENT_STATUS.yaml"

# Setup GitHub CLI
echo "Checking GitHub CLI authentication..."
gh auth status || gh auth login

# Create initial project board
echo "Creating GitHub project board..."
gh project create "Task Management" --org "$GITHUB_ORG" --public

echo "Setup complete! Next steps:"
echo "1. Customize DEVELOPMENT_STATUS.yaml"
echo "2. Run github_setup.sh to configure GitHub integration"
echo "3. Start creating and managing tasks"
