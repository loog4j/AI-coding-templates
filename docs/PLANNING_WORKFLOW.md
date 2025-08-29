# AI-Driven Project Planning Workflow

This document guides AI agents through the complete project planning and setup process, from initial conversation to fully populated project files.

## Planning Phase Workflow

### Step 1: Initial Project Discussion
When a user wants to start a new project, the AI should:

1. **Gather Project Requirements** using these questions:
   - What is the main goal/purpose of this project?
   - What type of project is this? (web app, mobile app, data analysis, etc.)
   - What technologies/tools do you want to use?
   - Who is the target audience/user?
   - What are the key features or components needed?
   - Are there any external integrations required?
   - What's your timeline or deadline?
   - What does success look like for this project?

2. **Clarify Technical Details**:
   - Development environment preferences
   - Deployment target (cloud, on-premise, etc.)
   - Performance requirements
   - Security considerations
   - Testing requirements

3. **Identify Constraints**:
   - Budget limitations
   - Time constraints
   - Resource availability
   - Technical limitations

### Step 2: Automated Project Setup
Once requirements are gathered, the AI should:

1. **Run Setup Script**:
   ```bash
   ./Project_Templates/setup-project.sh "Project Name" /path/to/project
   ```

2. **Populate MASTER_PLAN.md** with gathered information
3. **Create specific task files** based on project type and requirements
4. **Update PROGRESS.md** with initial planning state
5. **Customize .clinerules** for project-specific needs

### Step 3: Task Breakdown Generation
The AI should automatically:

1. **Analyze project requirements** and break into logical phases
2. **Generate specific tasks** (typically 8-12 tasks)
3. **Set task dependencies** and prerequisites
4. **Define validation criteria** for each task
5. **Create project-specific troubleshooting guides**

## AI Planning Prompts

### Project Type Templates

#### Web Application
```
Based on your web application requirements, I'll create:
- TASK-01: Environment setup and project structure
- TASK-02: Backend API development
- TASK-03: Database design and setup
- TASK-04: Frontend framework setup
- TASK-05: Core feature implementation
- TASK-06: User authentication
- TASK-07: Testing and validation
- TASK-08: Deployment and monitoring
```

#### Mobile Application
```
For your mobile app, I'll structure:
- TASK-01: Development environment setup
- TASK-02: App framework and navigation
- TASK-03: UI/UX implementation
- TASK-04: Core functionality development
- TASK-05: Data management and storage
- TASK-06: API integration
- TASK-07: Testing on devices
- TASK-08: App store preparation
```

#### Data Analysis Project
```
For your data analysis project:
- TASK-01: Environment and tools setup
- TASK-02: Data collection and ingestion
- TASK-03: Data cleaning and preprocessing
- TASK-04: Exploratory data analysis
- TASK-05: Model development/analysis
- TASK-06: Visualization and reporting
- TASK-07: Validation and testing
- TASK-08: Documentation and deployment
```

## Automated File Population

### MASTER_PLAN.md Population
The AI should replace placeholders with:
- **Project Goal**: From user requirements
- **Components**: Based on project type and features
- **Technical Requirements**: From technical discussion
- **Task Breakdown**: Generated task list
- **Success Criteria**: From user's definition of success
- **Timeline**: Based on user's deadline and task complexity

### Task File Generation
For each task, the AI should:
- **Set specific objectives** based on project requirements
- **Define prerequisites** from task dependencies
- **Create step-by-step instructions** for the specific technology stack
- **Add validation commands** appropriate to the tools being used
- **Include troubleshooting** for common issues in that domain

### PROGRESS.md Initialization
The AI should set:
- **Current state**: "Project planned and ready for execution"
- **Next action**: "Begin TASK-01: [specific first task]"
- **File states**: List all created files
- **Environment requirements**: Based on chosen technology stack

## Example AI Planning Session

### User Input:
"I want to create a task management web app using React and Node.js with user authentication and real-time updates."

### AI Response Process:
1. **Gather additional details** about database, deployment, features
2. **Run setup script** with project name
3. **Populate MASTER_PLAN.md** with:
   - Goal: Task management web application
   - Components: React frontend, Node.js backend, database, auth system
   - Tech stack: React, Node.js, Express, MongoDB, Socket.io
   - Features: User auth, task CRUD, real-time updates, responsive design

4. **Generate 8 specific tasks**:
   - TASK-01: Project setup and environment configuration
   - TASK-02: Backend API with Express and MongoDB
   - TASK-03: User authentication system
   - TASK-04: React frontend setup and routing
   - TASK-05: Task management features (CRUD)
   - TASK-06: Real-time updates with Socket.io
   - TASK-07: Testing and validation
   - TASK-08: Deployment and monitoring

5. **Update PROGRESS.md** with ready-to-execute state

## Validation Checklist for AI Planning

Before completing the planning phase, ensure:
- [ ] All placeholders in MASTER_PLAN.md are filled
- [ ] All task files are created with specific content
- [ ] Task dependencies are properly chained
- [ ] Validation commands are technology-appropriate
- [ ] PROGRESS.md shows clear next steps
- [ ] .clinerules reflects project-specific needs
- [ ] User has approved the plan before execution begins

## Planning Completion
Once planning is complete, the AI should:
1. **Present the complete plan** to the user for approval
2. **Explain the task sequence** and dependencies
3. **Confirm the technology choices** and approach
4. **Get user approval** before beginning execution
5. **Update PROGRESS.md** to show planning complete and ready for TASK-01

This ensures the user has a fully planned, AI-generated project structure ready for systematic execution.
