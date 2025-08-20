# Project Management Templates

This directory contains a comprehensive project management system designed for AI-assisted development and seamless handoffs between sessions or agents.

## Templates Included

### 1. MASTER_PLAN.md
The master project plan template that provides:
- Project overview and goals
- Component breakdown
- Technical requirements
- Task organization
- Success criteria
- AI context markers for seamless execution

### 2. TASK_TEMPLATE.md
Individual task template with:
- Clear objectives and prerequisites
- Step-by-step instructions
- Validation commands
- Troubleshooting guides
- AI-friendly context markers
- Progress tracking integration

### 3. PROGRESS.md
Real-time progress tracker featuring:
- Current state documentation
- File state tracking
- Handoff information
- Decision logging
- Issue tracking
- Environment status

### 4. PROJECT_CLINERULES.md
Comprehensive rules for using this system:
- Initialization process
- Task execution protocols
- Progress update requirements
- Error handling procedures
- Handoff protocols

## Quick Start

### Automated Setup (Recommended)

#### Using Bash (Linux/macOS):
```bash
./setup-project.sh "My Project Name" /path/to/project-directory
```

#### Using PowerShell (Windows):
```powershell
.\setup-project.ps1 -ProjectName "My Project Name" -ProjectDirectory "C:\path\to\project-directory"
```

### Manual Setup
1. Copy all templates to your project directory
2. Rename MASTER_PLAN.md to match your project
3. Copy PROJECT_CLINERULES.md as `.clinerules` in your project root
4. Follow the initialization process in PROJECT_CLINERULES.md

## Setup Scripts

### What the Setup Scripts Do

Both `setup-project.sh` (Bash) and `setup-project.ps1` (PowerShell) perform identical automated project initialization:

#### 1. **Creates Complete Project Structure**
```
your-project/
├── MASTER_PLAN.md      # Customized with your project name
├── PROGRESS.md         # Pre-filled with current date/time
├── .clinerules         # Project management rules
├── tasks/              # Task directory with starter files
│   ├── TASK_TEMPLATE.md    # Reference template
│   ├── TASK-01-placeholder.md
│   ├── TASK-02-placeholder.md
│   ├── TASK-03-placeholder.md
│   ├── TASK-04-placeholder.md
│   └── TASK-05-placeholder.md
├── src/                # Source code directory
├── tests/              # Test files directory
├── docs/               # Documentation directory
└── README.md           # Project-specific README
```

#### 2. **Automatic Customization**
- Replaces `[PROJECT_NAME]` placeholders with your actual project name
- Sets current date/time in PROGRESS.md
- Updates working directory paths throughout files
- Pre-fills initial progress state with next steps

#### 3. **Ready-to-Use State**
- All templates properly connected and cross-referenced
- Initial progress tracking established
- Project marked as "Ready for planning"
- Clear next steps documented

### Setup Script Examples

#### Bash Examples:
```bash
# Web application project
./setup-project.sh "E-commerce Website" ~/projects/ecommerce-site

# Data analysis project
./setup-project.sh "Sales Analytics Dashboard" ~/work/analytics-project

# Mobile app project
./setup-project.sh "Task Manager App" ~/dev/task-manager
```

#### PowerShell Examples:
```powershell
# Web application project
.\setup-project.ps1 -ProjectName "E-commerce Website" -ProjectDirectory "C:\Projects\ecommerce-site"

# Data analysis project
.\setup-project.ps1 -ProjectName "Sales Analytics Dashboard" -ProjectDirectory "C:\Work\analytics-project"

# Mobile app project
.\setup-project.ps1 -ProjectName "Task Manager App" -ProjectDirectory "C:\Dev\task-manager"
```

### AI-Driven Planning Workflow

For the best experience, use the **AI-driven planning workflow** instead of manual setup:

1. **Start a conversation with Cline** about your project idea
2. **Cline will gather requirements** using guided questions
3. **Cline runs the setup script** automatically
4. **Cline populates all files** with your specific project details
5. **You get a complete, ready-to-execute project plan**

See `PLANNING_WORKFLOW.md` for the complete AI planning process.

### After Setup (Manual or AI-Driven)

1. **Navigate to your project**: `cd /path/to/your-project`
2. **Review the generated plan**: Check MASTER_PLAN.md and task files
3. **Approve the approach**: Confirm the plan meets your needs
4. **Begin execution**: Start with TASK-01 and update PROGRESS.md

### Key Features
- **AI-Optimized**: Designed for seamless AI agent execution
- **Handoff-Ready**: Complete context preservation between sessions
- **Progress-Driven**: Mandatory progress tracking prevents lost work
- **Validation-Heavy**: Built-in verification at every step
- **Error-Resilient**: Comprehensive troubleshooting and recovery

### Critical Success Factors
1. **Always update PROGRESS.md** after every action
2. **Read PROGRESS.md first** when starting work
3. **Follow validation steps** in every task
4. **Document decisions** and deviations immediately
5. **Maintain file state tracking** throughout the project

## Template Structure

```
project-templates/
├── MASTER_PLAN.md          # Overall project architecture
├── TASK_TEMPLATE.md        # Individual task template
├── PROGRESS.md             # Progress tracking template
├── PROJECT_CLINERULES.md   # Usage rules and protocols
└── README.md               # This file
```

## Usage Examples

### Software Development
- Web applications
- Mobile apps
- APIs and microservices
- DevOps automation
- Database projects

### Creative Projects
- Content creation
- Design systems
- Documentation projects
- Marketing campaigns

### Business Projects
- Process automation
- Data analysis
- Report generation
- System integrations

## Best Practices

1. **Start with the master plan** - Define the full scope before creating tasks
2. **Break work into logical tasks** - Typically 8-12 tasks per project
3. **Chain prerequisites correctly** - Ensure tasks build on each other
4. **Update progress religiously** - This is the key to success
5. **Validate everything** - Use the provided validation commands
6. **Document decisions** - Future you (or another agent) will thank you

## Customization

These templates are designed to be flexible. Customize them for:
- Different project types
- Team-specific workflows
- Tool-specific requirements
- Organization standards

## Support

For issues or improvements:
1. Check the troubleshooting section in PROJECT_CLINERULES.md
2. Review the validation commands in task templates
3. Ensure PROGRESS.md is up to date
4. Follow the error handling protocols

## Version History

- v1.0: Initial template system with AI optimization
- Focus on progress tracking and handoff capabilities
- Comprehensive validation and error handling
- Support for multiple project types

---

**Remember**: The success of this system depends on consistent use of progress tracking and validation procedures. When in doubt, update PROGRESS.md!
