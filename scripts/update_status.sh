#!/bin/bash

# Task status update script
# Updates task status in DEVELOPMENT_STATUS.yaml and GitHub

# Check arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <task_id> <new_status> <details>"
    echo "Status must be one of: ready, in-progress, review, blocked, completed"
    exit 1
fi

TASK_ID=$1
NEW_STATUS=$2
DETAILS=$3

# Validate status
if [[ ! "$NEW_STATUS" =~ ^(ready|in-progress|review|blocked|completed)$ ]]; then
    echo "Error: Invalid status. Must be one of: ready, in-progress, review, blocked, completed"
    exit 1
fi

# Update status using Python
output=$(python3 - << EOF
import yaml
from datetime import datetime

# Load YAML
with open('.project/status/DEVELOPMENT_STATUS.yaml', 'r') as f:
    status = yaml.safe_load(f)

# Find and update task
task_found = False
task = None
for t in status['next_available_tasks']:
    if t['id'] == $TASK_ID:
        t['status'] = '$NEW_STATUS'
        task = t
        task_found = True
        break

if not task_found:
    print(f"Error: Task {$TASK_ID} not found")
    exit(1)

# Add activity log entry
log_entry = {
    'task_id': $TASK_ID,
    'action': f'Updated task {$TASK_ID} to {task["status"]}',
    'details': '$DETAILS',
    'timestamp': datetime.now().isoformat()
}

if 'ai_activity_log' not in status:
    status['ai_activity_log'] = []
status['ai_activity_log'].append(log_entry)

# Save updated YAML
with open('.project/status/DEVELOPMENT_STATUS.yaml', 'w') as f:
    yaml.dump(status, f, default_flow_style=False, sort_keys=False)

# Print task info for GitHub update
if 'github_issue' in task:
    print(f"GITHUB_ISSUE={task['github_issue']}")
EOF
)

# Get GitHub issue number from Python output
GITHUB_ISSUE=$(echo "$output" | grep "GITHUB_ISSUE=" | cut -d'=' -f2)

# Update GitHub issue if it exists
if [ ! -z "$GITHUB_ISSUE" ]; then
    gh issue edit "$GITHUB_ISSUE" --add-label "$NEW_STATUS"
    echo "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/issues/$GITHUB_ISSUE"
else
    echo "Note: No GitHub issue associated with task $TASK_ID"
fi

echo "Task $TASK_ID updated to status: $NEW_STATUS"
