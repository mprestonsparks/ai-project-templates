#!/bin/bash

# GitHub integration setup script
# This script configures GitHub Issues and Project Board

echo "Setting up GitHub integration..."

# Create labels
gh label create "ready" --color "0E8A16" --description "Task is ready to be worked on"
gh label create "in-progress" --color "FFA500" --description "Task is currently being worked on"
gh label create "blocked" --color "D93F0B" --description "Task is blocked by dependencies"
gh label create "review" --color "1D76DB" --description "Task is awaiting review"
gh label create "completed" --color "0E8A16" --description "Task is completed"

# Create initial issues from DEVELOPMENT_STATUS.yaml
python3 - << 'EOF'
import yaml
import subprocess

def create_github_issue(task):
    title = f'Task {task["id"]}: {task["name"]}'
    body = f"""
Priority: {task["priority"]}
Status: {task["status"]}
Blocking: {", ".join(map(str, task["blocking"]))}
Prerequisites met: {task["prerequisites_met"]}
"""
    subprocess.run(['gh', 'issue', 'create', '--title', title, '--body', body])

with open('.project/status/DEVELOPMENT_STATUS.yaml', 'r') as f:
    status = yaml.safe_load(f)
    for task in status['next_available_tasks']:
        if not task.get('github_issue'):
            create_github_issue(task)
EOF

echo "GitHub integration setup complete!"
echo "Next steps:"
echo "1. Configure project board columns"
echo "2. Link issues to project board"
echo "3. Start managing tasks"
