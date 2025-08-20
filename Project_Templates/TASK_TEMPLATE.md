# TASK-XX: [Task Name]

## Objective
[Clear, specific description of what this task accomplishes. What is the end goal?]

## Prerequisites
- [ ] [TASK-XX] completed (dependency)
- [ ] [Required tool/service] available
- [ ] [Required file/resource] exists
- [ ] [Environment/setup requirement] met

## AI_CONTEXT
```markdown
Working Directory: [/path/to/project]
Key Files: [list of files this task will modify/create]
External Tools Needed: [CLI tools, APIs, services required]
Environment Variables: [any env vars needed]
Ports/Services: [if task starts services, which ports]
```

## Steps

### Step 1: [Step Name]
[Detailed description of what to do]

**Commands to run:**
```bash
[specific command]
```

**Expected outcome:**
- [What should happen]
- [Files that should be created/modified]

**Validation:**
```bash
[command to verify step worked]
```

### Step 2: [Step Name]
[Detailed description of what to do]

**Commands to run:**
```bash
[specific command]
```

**Expected outcome:**
- [What should happen]
- [Files that should be created/modified]

**Validation:**
```bash
[command to verify step worked]
```

### Step 3: [Step Name]
[Detailed description of what to do]

**File to create/modify:** `[filename]`
**Content/Changes:**
```[language]
[code or content to add]
```

**Validation:**
```bash
[command to verify step worked]
```

## Decision Points
```markdown
## DECISION_LOGIC
- IF [condition] THEN [action] ELSE [alternative action]
- IF file exists THEN [update action] ELSE [create action]
- IF error "specific error" THEN [recovery action]
- IF environment is [dev/prod] THEN [environment-specific action]
```

## Validation Checklist
- [ ] [Specific validation item 1]
- [ ] [Specific validation item 2]
- [ ] [Specific validation item 3]
- [ ] [Files created/modified as expected]
- [ ] [Services running if applicable]
- [ ] [Tests passing if applicable]

## Validate With Commands
```bash
# Test 1: [Description]
[command]
# Expected: [expected output]

# Test 2: [Description]
[command]
# Expected: [expected output]

# Test 3: [Description]
[command]
# Expected: [expected output]
```

## Troubleshooting

### Common Error 1: [Error Description]
**Symptoms:** [How to recognize this error]
**Cause:** [Why this happens]
**Solution:**
```bash
[commands to fix]
```

### Common Error 2: [Error Description]
**Symptoms:** [How to recognize this error]
**Cause:** [Why this happens]
**Solution:**
```bash
[commands to fix]
```

## Output/Deliverables
- [Specific file created: filename.ext]
- [Service running on port XXXX]
- [Configuration updated in file.config]
- [Database table created with schema]
- [API endpoint available at /path]

## File State Changes
```markdown
## FILES_MODIFIED
- [filename]: CREATED - [brief description of content]
- [filename]: MODIFIED - [what was changed]
- [filename]: DELETED - [why it was removed]
```

## Progress Update Template
```markdown
## PROGRESS_UPDATE
Task: TASK-XX
Status: [IN_PROGRESS/COMPLETED/BLOCKED]
Last Step Completed: [Step X]
Next Step: [Step Y]
Time Spent: [duration]
Issues Encountered: [any problems]
Files Changed: [list]
```

## Notes
- [Important considerations for this task]
- [Assumptions made]
- [Alternative approaches considered]
- [Performance considerations]
- [Security considerations]

## Next Steps
After completing this task:
1. Update PROGRESS.md with completion status
2. Verify all validation items pass
3. Proceed to [TASK-XX] or [specific next action]
4. [Any cleanup or follow-up actions needed]

## Rollback Plan
If this task needs to be undone:
1. [Step to reverse changes]
2. [Files to restore/delete]
3. [Services to stop/restart]
4. [Configuration to revert]
