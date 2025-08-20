# Project Template Setup Script (PowerShell)
# Usage: .\setup-project.ps1 -ProjectName "My Project" -ProjectDirectory "C:\path\to\project"

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectDirectory
)

# Colors for output
$Colors = @{
    Red = "Red"
    Green = "Green"
    Yellow = "Yellow"
    Blue = "Cyan"
}

# Function to print colored output
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor $Colors.Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor $Colors.Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor $Colors.Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor $Colors.Red
}

# Get template directory (where this script is located)
$TemplateDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Status "Setting up project: $ProjectName"
Write-Status "Target directory: $ProjectDirectory"

# Create project directory if it doesn't exist
if (-not (Test-Path $ProjectDirectory)) {
    Write-Status "Creating project directory..."
    New-Item -ItemType Directory -Path $ProjectDirectory -Force | Out-Null
}

# Create tasks subdirectory
Write-Status "Creating tasks directory..."
$TasksDir = Join-Path $ProjectDirectory "tasks"
New-Item -ItemType Directory -Path $TasksDir -Force | Out-Null

# Copy and customize MASTER_PLAN.md
Write-Status "Setting up master plan..."
$MasterPlanSource = Join-Path $TemplateDir "MASTER_PLAN.md"
$MasterPlanDest = Join-Path $ProjectDirectory "MASTER_PLAN.md"
$MasterPlanContent = Get-Content $MasterPlanSource -Raw
$MasterPlanContent = $MasterPlanContent -replace '\[PROJECT_NAME\]', $ProjectName
Set-Content -Path $MasterPlanDest -Value $MasterPlanContent

# Copy PROGRESS.md and customize
Write-Status "Setting up progress tracker..."
$ProgressSource = Join-Path $TemplateDir "PROGRESS.md"
$ProgressDest = Join-Path $ProjectDirectory "PROGRESS.md"
$ProgressContent = Get-Content $ProgressSource -Raw
$ProgressContent = $ProgressContent -replace '\[PROJECT_NAME\]', $ProjectName

# Set initial date
$CurrentDate = Get-Date -Format "yyyy-MM-dd"
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd HH:mm"
$ProgressContent = $ProgressContent -replace '\[YYYY-MM-DD\]', $CurrentDate
$ProgressContent = $ProgressContent -replace '\[YYYY-MM-DD HH:MM\]', $CurrentDateTime
$ProgressContent = $ProgressContent -replace '\[/current/working/path\]', $ProjectDirectory
Set-Content -Path $ProgressDest -Value $ProgressContent

# Copy .clinerules
Write-Status "Setting up project rules..."
$ClineruleSource = Join-Path $TemplateDir "PROJECT_CLINERULES.md"
$ClineruleDest = Join-Path $ProjectDirectory ".clinerules"
Copy-Item $ClineruleSource $ClineruleDest

# Copy task template for reference
Write-Status "Adding task template..."
$TaskTemplateSource = Join-Path $TemplateDir "TASK_TEMPLATE.md"
$TaskTemplateDest = Join-Path $TasksDir "TASK_TEMPLATE.md"
Copy-Item $TaskTemplateSource $TaskTemplateDest

# Create initial task files (user can customize these)
Write-Status "Creating initial task files..."
for ($i = 1; $i -le 5; $i++) {
    $TaskNumber = $i.ToString("00")
    $TaskFile = Join-Path $TasksDir "TASK-$TaskNumber-placeholder.md"
    $TaskContent = Get-Content $TaskTemplateSource -Raw
    $TaskContent = $TaskContent -replace 'TASK-XX', "TASK-$TaskNumber"
    Set-Content -Path $TaskFile -Value $TaskContent
}

# Create basic project structure
Write-Status "Creating basic project structure..."
$SrcDir = Join-Path $ProjectDirectory "src"
$TestsDir = Join-Path $ProjectDirectory "tests"
$DocsDir = Join-Path $ProjectDirectory "docs"
New-Item -ItemType Directory -Path $SrcDir -Force | Out-Null
New-Item -ItemType Directory -Path $TestsDir -Force | Out-Null
New-Item -ItemType Directory -Path $DocsDir -Force | Out-Null

# Create a basic README
Write-Status "Creating project README..."
$ReadmeContent = @"
# $ProjectName

## Project Overview
[Add your project description here]

## Getting Started
1. Review MASTER_PLAN.md for project overview
2. Check PROGRESS.md for current status
3. Follow tasks in order: TASK-01 → TASK-02 → etc.
4. Update PROGRESS.md after every action

## Project Structure
``````
$ProjectName/
├── MASTER_PLAN.md      # Project overview and architecture
├── PROGRESS.md         # Real-time progress tracking
├── .clinerules         # Project management rules
├── tasks/              # Individual task files
├── src/                # Source code
├── tests/              # Test files
├── docs/               # Documentation
└── README.md           # This file
``````

## Important Rules
1. **Always read PROGRESS.md first** before starting work
2. **Update PROGRESS.md** after every action
3. **Follow task validation steps** for each task
4. **Document decisions** and changes immediately

## Next Steps
1. Customize MASTER_PLAN.md with your project details
2. Update task files in tasks/ directory
3. Begin with TASK-01
4. Keep PROGRESS.md updated throughout

For detailed usage instructions, see .clinerules file.
"@

$ReadmeDest = Join-Path $ProjectDirectory "README.md"
Set-Content -Path $ReadmeDest -Value $ReadmeContent

# Set initial progress state
Write-Status "Setting initial progress state..."
$InitialProgress = @"

## Initial Setup Complete
- **Setup Date**: $CurrentDateTime
- **Next Action**: Customize MASTER_PLAN.md with project details
- **Tasks Created**: TASK-01 through TASK-05 (placeholders)
- **Status**: Ready for project planning

## Immediate Next Steps
1. Edit MASTER_PLAN.md with your project details
2. Customize task files in tasks/ directory
3. Update this PROGRESS.md with your first real action
4. Begin executing TASK-01

"@

Add-Content -Path $ProgressDest -Value $InitialProgress

Write-Success "Project setup complete!"
Write-Status "Project created at: $ProjectDirectory"
Write-Status ""
Write-Status "Next steps:"
Write-Status "1. cd `"$ProjectDirectory`""
Write-Status "2. Edit MASTER_PLAN.md with your project details"
Write-Status "3. Customize task files in tasks/ directory"
Write-Status "4. Update PROGRESS.md and begin with TASK-01"
Write-Status ""
Write-Warning "Remember: Always update PROGRESS.md after every action!"
