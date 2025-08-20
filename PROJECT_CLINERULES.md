# Project Management System - Cline Rules

## Overview
This project uses a structured approach with master planning, task breakdown, and continuous progress tracking. These rules ensure consistent execution and seamless handoffs between sessions or agents.

## Project Structure
Every project using this system must have:
```
/project-root/
├── MASTER_PLAN.md      # Overall project plan and architecture
├── PROGRESS.md         # Real-time progress tracking (CRITICAL)
├── tasks/              # Individual task files
│   ├── TASK-01-[name].md
│   ├── TASK-02-[name].md
│   └── ...
├── .clinerules         # This file (project-specific copy)
└── [project files]    # Actual project code/content
```

## CRITICAL RULE: Progress Updates
**MANDATORY**: Update PROGRESS.md after EVERY significant action:
- After completing any task step
- After creating/modifying any file
- After running any command
- After encountering any error or blocker
- Before switching tasks
- Before ending any work session
- After making any decisions

**Update Format**:
```markdown
## Last Updated: [YYYY-MM-DD HH:MM]
## Last Action: [Specific action taken]
## Current State: [Exactly where we are now]
## Next Step: [Immediate next action to take]
```

## Initialization Process

### AI-Driven Planning (Recommended)
When starting a new project, follow the AI-driven planning workflow:

1. **Project Requirements Gathering**:
   - Ask user about project goals, type, and requirements
   - Clarify technical details and constraints
   - Identify success criteria and timeline
   - Reference PLANNING_WORKFLOW.md for complete question list

2. **Automated Setup**:
   ```bash
   # Run setup script with project details
   ./Project_Templates/setup-project.sh "Project Name" /path/to/project
   ```

3. **AI-Powered File Population**:
   - Populate MASTER_PLAN.md with gathered requirements
   - Generate specific task files based on project type
   - Create technology-appropriate validation commands
   - Set up project-specific troubleshooting guides
   - Update PROGRESS.md with planning completion state

4. **Plan Validation**:
   - Present complete plan to user for approval
   - Ensure all placeholders are filled with real content
   - Verify task dependencies are logical
   - Confirm technology choices match requirements

### Manual Setup (Alternative)
If not using AI-driven planning:

1. **Create Project Structure**:
   - Copy templates from project-templates/ to new project directory
   - Rename MASTER_PLAN.md to match project
   - Create tasks/ directory
   - Copy this file as .clinerules in project root

2. **Configure Master Plan**:
   - Replace all [PLACEHOLDER] values in MASTER_PLAN.md
   - Define project goal and components
   - Break down into logical tasks (typically 8-12 tasks)
   - Set success criteria and milestones
   - Update AI_CONTEXT sections with project-specific info

3. **Create Task Files**:
   - Copy TASK_TEMPLATE.md for each task
   - Name files: TASK-01-setup.md, TASK-02-config.md, etc.
   - Fill in all sections for each task
   - Ensure prerequisites chain correctly
   - Add project-specific validation commands

4. **Initialize Progress Tracking**:
   - Fill in PROGRESS.md with project details
   - Set initial state and first task
   - Update handoff information
   - Set up file state tracking

## Task Execution Rules

### Before Starting Any Task
1. **READ PROGRESS.md FIRST** - Understand current state
2. Verify all prerequisites are met
3. Check that previous task is actually completed
4. Confirm working directory and environment
5. Run any verification commands listed

### During Task Execution
1. Follow task steps sequentially
2. Run validation commands after each step
3. **Update PROGRESS.md after each major step**
4. Document any deviations or issues immediately
5. If blocked, update progress with blocker details

### After Completing Each Step
1. Run validation commands
2. Update PROGRESS.md with:
   - Step completed
   - Files modified
   - Next step to take
   - Any issues encountered
3. Verify expected outcomes match actual results

### Task Completion
1. Complete all validation checklist items
2. Run all "Validate With Commands"
3. Update PROGRESS.md with task completion
4. Update file state tracking
5. Verify next task prerequisites are met

## Error Handling Protocol

### When Errors Occur
1. **IMMEDIATELY** update PROGRESS.md with:
   - Error description
   - What was being attempted
   - Current state of files/environment
   - Attempted solutions
2. Check task's troubleshooting section
3. Try documented solutions
4. If unresolved, mark as BLOCKED in progress

### Recovery Process
1. Document the solution in PROGRESS.md
2. Update task file with new troubleshooting info
3. Continue from documented recovery point
4. Verify system state before proceeding

## Handoff Protocol

### Ending a Work Session
1. **MANDATORY**: Update PROGRESS.md with complete handoff info:
   ```markdown
   ## HANDOFF_CONTEXT
   Current Working Directory: [exact path]
   Last Successful Action: [what was just completed]
   Immediate Next Step: [exactly what to do next]
   Required Tools: [any tools/commands needed]
   Key Files to Check: [files to verify before starting]
   Environment Setup: [any setup commands to run]
   Active Services: [any running processes]
   ```

### Starting a New Session
1. **ALWAYS READ PROGRESS.md FIRST**
2. Verify working directory matches documented path
3. Check that key files exist and are in expected state
4. Run environment verification commands
5. Confirm next step before proceeding
6. If anything doesn't match, investigate before continuing

## File Management Rules

### File State Tracking
- Document every file creation/modification in PROGRESS.md
- Include timestamp and brief description of changes
- Track critical files status (exists/missing/outdated)
- Note any file dependencies or relationships

### Backup Strategy
- Before major changes, note current state in PROGRESS.md
- Document rollback procedures in task files
- Keep track of configuration changes
- Note any irreversible actions

## Decision Making

### When Decisions Are Needed
1. Document the decision point in PROGRESS.md
2. List options considered
3. Record decision made and rationale
4. Update relevant task files if approach changes
5. Note any implications for future tasks

### Decision Documentation Format
```markdown
## DECISION: [Date] - [Decision Title]
**Context**: [Why decision was needed]
**Options**: [What was considered]
**Decision**: [What was chosen]
**Rationale**: [Why this was chosen]
**Impact**: [How this affects other tasks]
```

## Quality Assurance

### Validation Requirements
- Every task must have specific validation steps
- Commands must be provided to verify success
- Expected outputs must be documented
- Failure scenarios must be covered

### Testing Protocol
- Run validation commands after each step
- Test error conditions when possible
- Verify integrations work as expected
- Document test results in PROGRESS.md

## Communication Guidelines

### Progress Updates
- Update PROGRESS.md instead of just commenting
- Be specific about what was accomplished
- Include exact commands run and results
- Note any deviations from planned approach

### Issue Reporting
- Document problems immediately in PROGRESS.md
- Include error messages verbatim
- Note system state when error occurred
- Record attempted solutions

## Project Types

### Software Development Projects
- Include build/test commands in validation
- Track dependencies and environment setup
- Document API endpoints and configurations
- Note database schema changes

### Creative Projects
- Track asset files and versions
- Document design decisions
- Note tool-specific requirements
- Include review/approval checkpoints

### Business/Process Projects
- Document stakeholder communications
- Track deliverable status
- Note approval requirements
- Include timeline dependencies

## Advanced Features

### Parallel Task Execution
- Mark tasks that can run in parallel
- Document shared dependencies
- Coordinate file access conflicts
- Update progress for all parallel tracks

### External Dependencies
- Document all external services/APIs
- Include authentication requirements
- Note version dependencies
- Track service status and availability

### Environment Management
- Document environment-specific configurations
- Track different deployment targets
- Note environment setup requirements
- Include environment validation commands

## Troubleshooting Common Issues

### "Can't find where I left off"
- Check PROGRESS.md handoff section
- Verify working directory
- Run environment verification commands
- Check file state tracking

### "Previous step seems incomplete"
- Check validation commands in task file
- Review PROGRESS.md for actual completion status
- Verify expected files exist
- Run diagnostic commands

### "Task prerequisites not met"
- Check PROGRESS.md for actual task completion
- Verify all validation items were completed
- Check file state tracking
- Review task dependencies

## Best Practices

### For AI Agents
1. Always read PROGRESS.md before taking any action
2. Update progress after every significant step
3. Use exact commands provided in task files
4. Verify outcomes match expectations
5. Document any deviations immediately

### For Human Users
1. Keep PROGRESS.md updated when working manually
2. Follow the same validation steps
3. Document decisions and changes
4. Maintain file state tracking
5. Use consistent naming conventions

### For Team Projects
1. Coordinate progress updates
2. Document handoffs between team members
3. Use consistent terminology
4. Maintain shared understanding of project state
5. Regular progress reviews

## Maintenance

### Regular Reviews
- Weekly: Review progress and update timelines
- After major milestones: Update master plan if needed
- Monthly: Review and update task templates
- Project end: Document lessons learned

### Template Updates
- Improve task templates based on experience
- Add new troubleshooting scenarios
- Update validation commands
- Enhance progress tracking sections

---

## CRITICAL REMINDERS

1. **PROGRESS.md is the single source of truth** for project state
2. **Update progress after EVERY action** - no exceptions
3. **Read progress before starting** any work session
4. **Validate every step** using provided commands
5. **Document decisions and deviations** immediately
6. **Handoff information must be complete** for seamless transitions

**Failure to follow these rules will result in lost context, duplicated work, and project delays.**
