# AI Integration Guide

This document outlines how AI assistants should interact with the task management system.

## Core Responsibilities

1. **Status File Management**
   - Read and parse `DEVELOPMENT_STATUS.yaml`
   - Update task statuses and assignments
   - Log activities in `ai_activity_log`

2. **Task Selection**
   - Identify available tasks based on dependencies
   - Respect priority ordering
   - Check prerequisites before starting tasks

3. **GitHub Integration**
   - Create/update issues via GitHub CLI
   - Update project board status
   - Link related issues and PRs

## Working with DEVELOPMENT_STATUS.yaml

### Reading Status
```python
import yaml

def read_status():
    with open('DEVELOPMENT_STATUS.yaml', 'r') as f:
        return yaml.safe_load(f)
```

### Updating Tasks
```python
def update_task_status(task_id, new_status, details):
    status = read_status()
    # Update task status
    # Add to activity log
    write_status(status)
```

### Logging Activities
```python
from datetime import datetime

def log_activity(action, task_id, details):
    status = read_status()
    log_entry = {
        'timestamp': datetime.now().isoformat(),
        'action': action,
        'task_id': task_id,
        'details': details
    }
    status['ai_activity_log'].append(log_entry)
    write_status(status)
```

## GitHub CLI Commands

### Issue Management
```bash
# Create issue
gh issue create --title "Task Title" --body "Description"

# Update issue
gh issue edit [number] --add-label "in-progress"

# Close issue
gh issue close [number]
```

### Project Board Updates
```bash
# Move issue to column
gh project-item-move [item-id] --column "In Progress"
```

## Best Practices

1. **Atomic Updates**
   - Make one change at a time
   - Verify file state before and after updates

2. **Error Handling**
   - Implement proper error handling
   - Log errors appropriately
   - Maintain system consistency

3. **Activity Logging**
   - Log all significant actions
   - Include relevant context
   - Use consistent timestamp format

4. **Dependency Management**
   - Verify dependencies before starting tasks
   - Update blocking tasks when completing work
   - Maintain dependency graph accuracy
