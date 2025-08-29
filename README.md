# AI-Powered Project Management System

This is a project management framework designed to be run by an AI coding agent like Cline. It provides the structure, rules, and tools necessary for an AI to manage complex software projects from initial idea to final deployment, ensuring context is never lost.

## The 3-Step AI Workflow

Getting started is as simple as having a conversation.

1. **Start a Conversation**  
   Tell your AI agent what you want to build. For example:  
   > "I want to create a task management web app using React and Node.js."

2. **Collaborate on the Plan**  
   The AI will ask clarifying questions to understand your requirements. It will then generate a complete project plan, including a master plan, a full task list, and all necessary configuration.

3. **Execute the Plan**  
   Once you approve the plan, the AI will begin executing the tasks step-by-step, using the built-in scripts to automatically track its progress and handle errors.

That's it. The AI handles the rest.

## What the AI Delivers

After the planning phase, you'll have a fully structured project, ready for execution, which includes:

- **`MASTER_PLAN.md`**: A detailed document outlining the project's architecture, goals, and requirements.
- **`PROGRESS.md`**: A real-time dashboard tracking every action, decision, and file change.
- **`project.json`**: A central configuration file for all project settings.
- **`tasks/`**: A directory of granular, step-by-step tasks with validation and error handling.
- **A complete project scaffold** with `src/`, `tests/`, and `docs/` directories.
- **Bug and feature tracking** with automated report generation.

## Key Features for AI Agents

This system empowers AI agents with:

- **Automated Progress Tracking**: The `run-task.sh` script automatically logs every command's success or failure to `PROGRESS.md`.
- **Centralized Configuration**: A `project.json` file provides a single source of truth for all project settings.
- **Environment Validation**: A utility script (`check_environment`) ensures all required tools are installed before work begins.
- **Seamless Handoffs**: The detailed `PROGRESS.md` and `.clinerules` ensure that context is perfectly preserved between work sessions.
- **Error Recovery**: Built-in troubleshooting guides and rollback procedures for when things go wrong.

## Example AI Conversation

Here's what a typical interaction looks like:

**You:** "I want to build a REST API for a blog platform using Node.js and PostgreSQL."

**AI:** "I'll help you create that! Let me ask a few questions to build the perfect plan:
- What authentication method do you prefer? (JWT, OAuth, etc.)
- Do you need user roles (admin, author, reader)?
- What deployment target? (AWS, Docker, etc.)
- Any specific frameworks? (Express, Fastify, etc.)"

**You:** [Answer the questions]

**AI:** "Perfect! I'm creating your project structure now..."

*[AI runs setup script, generates 8-10 specific tasks, populates all templates]*

**AI:** "Your blog API project is ready! I've created a complete plan with tasks like 'Set up Express server', 'Design database schema', 'Implement authentication', etc. Should I begin with TASK-01: Environment Setup?"

## Under the Hood: The Tooling

For advanced users or manual intervention, the system is powered by:

### Core Scripts
- **`setup-project.sh` / `.ps1`**: The core scripts that build the project structure. The AI calls this for you.
- **`run-task.sh`**: Wrapper for executing commands with automatic progress logging.
- **`config-utils.sh`**: Helper functions for reading and writing to `project.json`.

### Reporting Tools
- **`add-bug.sh`**: Creates timestamped bug reports with comprehensive templates.
- **`add-feature.sh`**: Creates timestamped feature requests with user stories and acceptance criteria.
- **`security-check.sh`**: Generates comprehensive security analysis reports with threat modeling.

### Templates
- **`MASTER_PLAN.md`**: Project architecture and requirements template.
- **`TASK_TEMPLATE.md`**: Individual task template with validation and troubleshooting.
- **`PROGRESS.md`**: Real-time progress tracking template.
- **`PROJECT_CLINERULES.md`**: Comprehensive rules for AI agents.

## Manual Setup (If Needed)

If you need to set up a project manually:

```bash
# Clone or copy this template directory
./scripts/setup-project.sh "My Project Name" /path/to/project

# Or on Windows:
.\scripts\setup-project.ps1 -ProjectName "My Project Name" -ProjectDirectory "C:\path\to\project"
```

## Best Practices for AI Agents

1. **Always read `PROGRESS.md` first** when resuming work
2. **Use `run-task.sh`** for command execution to ensure automatic logging
3. **Update configuration** via `project.json` rather than editing multiple files
4. **Validate environment** before starting work sessions
5. **Document all decisions** in `PROGRESS.md` for future context

## Why This System Works

- **Context Preservation**: Never lose track of what was done, what failed, and what's next
- **Structured Approach**: Break complex projects into manageable, validated tasks
- **Error Resilience**: Built-in recovery procedures and troubleshooting guides
- **Handoff Ready**: Seamless transitions between work sessions or different AI agents
- **Progress Driven**: Mandatory progress tracking prevents lost work and duplicated effort

---

**Ready to start?** Just tell your AI agent what you want to build, and let the system handle the rest!
