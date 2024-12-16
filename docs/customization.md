# Customization Guide

## Project Fields

### Status Field
The default Status field includes:
- Ready
- In Progress
- Blocked
- Review
- Completed

To modify these options:
1. Visit your project settings
2. Find the Status field
3. Click Edit to modify options

### Custom Fields
Add fields based on your needs:
- Priority (Single select)
- Due Date (Date)
- Effort (Number)
- Labels (Multiple select)

## Automation Rules

### Status Automation
Example rules:
1. When an issue is closed:
   - Set Status to Completed

2. When a PR is opened:
   - Set Status to Review

3. When an issue is assigned:
   - Set Status to In Progress

### Setting Up Rules
1. Go to project settings
2. Click on Workflows
3. Create new workflow
4. Define triggers and actions

## Integration Options

### GitHub Actions
- Link project tasks to workflows
- Update task status based on CI/CD
- Auto-assign reviewers

### External Tools
- Jira sync
- Slack notifications
- Time tracking

## Best Practices

1. **Field Naming**
   - Use clear, consistent names
   - Add descriptions for clarity
   - Consider sorting order

2. **Automation**
   - Start simple
   - Test thoroughly
   - Document rules

3. **Views**
   - Create role-specific views
   - Set default grouping
   - Configure filters
