#!/bin/bash

# Project Template Setup Script
# Usage: ./setup-project.sh <project-name> <project-directory>

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ $# -ne 2 ]; then
    print_error "Usage: $0 <project-name> <project-directory>"
    print_error "Example: $0 'My Web App' /path/to/my-web-app"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_DIR="$2"
TEMPLATE_DIR="$(dirname "$0")"

print_status "Setting up project: $PROJECT_NAME"
print_status "Target directory: $PROJECT_DIR"

# Create project directory if it doesn't exist
if [ ! -d "$PROJECT_DIR" ]; then
    print_status "Creating project directory..."
    mkdir -p "$PROJECT_DIR"
fi

# Create tasks subdirectory
print_status "Creating tasks directory..."
mkdir -p "$PROJECT_DIR/tasks"

# Copy and customize MASTER_PLAN.md
print_status "Setting up master plan..."
cp "$TEMPLATE_DIR/MASTER_PLAN.md" "$PROJECT_DIR/MASTER_PLAN.md"
sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" "$PROJECT_DIR/MASTER_PLAN.md"
rm "$PROJECT_DIR/MASTER_PLAN.md.bak" 2>/dev/null || true

# Copy PROGRESS.md and customize
print_status "Setting up progress tracker..."
cp "$TEMPLATE_DIR/PROGRESS.md" "$PROJECT_DIR/PROGRESS.md"
sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" "$PROJECT_DIR/PROGRESS.md"
# Set initial date
CURRENT_DATE=$(date '+%Y-%m-%d')
CURRENT_DATETIME=$(date '+%Y-%m-%d %H:%M')
sed -i.bak "s/\[YYYY-MM-DD\]/$CURRENT_DATE/g" "$PROJECT_DIR/PROGRESS.md"
sed -i.bak "s/\[YYYY-MM-DD HH:MM\]/$CURRENT_DATETIME/g" "$PROJECT_DIR/PROGRESS.md"
sed -i.bak "s|\[/current/working/path\]|$PROJECT_DIR|g" "$PROJECT_DIR/PROGRESS.md"
rm "$PROJECT_DIR/PROGRESS.md.bak" 2>/dev/null || true

# Copy .clinerules
print_status "Setting up project rules..."
cp "$TEMPLATE_DIR/PROJECT_CLINERULES.md" "$PROJECT_DIR/.clinerules"

# Copy task template for reference
print_status "Adding task template..."
cp "$TEMPLATE_DIR/TASK_TEMPLATE.md" "$PROJECT_DIR/tasks/"

# Create initial task files (user can customize these)
print_status "Creating initial task files..."
for i in {01..05}; do
    TASK_FILE="$PROJECT_DIR/tasks/TASK-$i-placeholder.md"
    cp "$TEMPLATE_DIR/TASK_TEMPLATE.md" "$TASK_FILE"
    sed -i.bak "s/TASK-XX/TASK-$i/g" "$TASK_FILE"
    rm "$TASK_FILE.bak" 2>/dev/null || true
done

# Create basic project structure
print_status "Creating basic project structure..."
mkdir -p "$PROJECT_DIR/src"
mkdir -p "$PROJECT_DIR/tests"
mkdir -p "$PROJECT_DIR/docs"

# Create a basic README
print_status "Creating project README..."
cat > "$PROJECT_DIR/README.md" << EOF
# $PROJECT_NAME

## Project Overview
[Add your project description here]

## Getting Started
1. Review MASTER_PLAN.md for project overview
2. Check PROGRESS.md for current status
3. Follow tasks in order: TASK-01 → TASK-02 → etc.
4. Update PROGRESS.md after every action

## Project Structure
\`\`\`
$PROJECT_NAME/
├── MASTER_PLAN.md      # Project overview and architecture
├── PROGRESS.md         # Real-time progress tracking
├── .clinerules         # Project management rules
├── tasks/              # Individual task files
├── src/                # Source code
├── tests/              # Test files
├── docs/               # Documentation
└── README.md           # This file
\`\`\`

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
EOF

# Set initial progress state
print_status "Setting initial progress state..."
cat >> "$PROJECT_DIR/PROGRESS.md" << EOF

## Initial Setup Complete
- **Setup Date**: $CURRENT_DATETIME
- **Next Action**: Customize MASTER_PLAN.md with project details
- **Tasks Created**: TASK-01 through TASK-05 (placeholders)
- **Status**: Ready for project planning

## Immediate Next Steps
1. Edit MASTER_PLAN.md with your project details
2. Customize task files in tasks/ directory
3. Update this PROGRESS.md with your first real action
4. Begin executing TASK-01

EOF

print_success "Project setup complete!"
print_status "Project created at: $PROJECT_DIR"
print_status ""
print_status "Next steps:"
print_status "1. cd $PROJECT_DIR"
print_status "2. Edit MASTER_PLAN.md with your project details"
print_status "3. Customize task files in tasks/ directory"
print_status "4. Update PROGRESS.md and begin with TASK-01"
print_status ""
print_warning "Remember: Always update PROGRESS.md after every action!"
