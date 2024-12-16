#!/bin/bash

# Task status update script
# Usage: ./update_status.sh <task_id> <new_status> [details]

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <task_id> <new_status> [details]"
    exit 1
fi

TASK_ID=$1
NEW_STATUS=$2
DETAILS=${3:-"No additional details"}

# Update DEVELOPMENT_STATUS.yaml
python3 - << EOF
import yaml
from datetime import datetime

def update_status(task_id, new_status, details):
    with open('DEVELOPMENT_STATUS.yaml', 'r') as f:
        status = yaml.safe_load(f)
    
    # Update task status
    for task in status['next_available_tasks']:
        if task['id'] == int(task_id):
            task['status'] = new_status
            break
    
    # Add to activity log
    log_entry = {
        'timestamp': datetime.now().isoformat(),
        'action': f"Updated task {task_id} to {new_status}",
        'task_id': int(task_id),
        'details': details
    }
    status['ai_activity_log'].append(log_entry)
    
    with open('DEVELOPMENT_STATUS.yaml', 'w') as f:
        yaml.dump(status, f, default_flow_style=False)

update_status('$TASK_ID', '$NEW_STATUS', '$DETAILS')
EOF

# Update GitHub issue
gh issue edit $TASK_ID --add-label "$NEW_STATUS"

echo "Task $TASK_ID updated to status: $NEW_STATUS"
