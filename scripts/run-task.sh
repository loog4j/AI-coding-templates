#!/bin/bash

# Automated Task Runner with Progress Logging
# Usage: ./run-task.sh "command to run" [description]

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

# Check if command is provided
if [ $# -eq 0 ]; then
    print_error "Usage: $0 \"command to run\" [description]"
    print_error "Example: $0 \"npm install\" \"Installing project dependencies\""
    exit 1
fi

COMMAND="$1"
DESCRIPTION="${2:-$COMMAND}"
PROGRESS_FILE="PROGRESS.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Source config utilities if available
if [ -f "config-utils.sh" ]; then
    source config-utils.sh
fi

# Function to update progress file
update_progress() {
    local status="$1"
    local details="$2"
    local next_step="$3"
    
    if [ ! -f "$PROGRESS_FILE" ]; then
        print_warning "PROGRESS.md not found, creating basic entry"
        echo "# Project Progress" > "$PROGRESS_FILE"
        echo "" >> "$PROGRESS_FILE"
    fi
    
    # Create progress entry
    cat >> "$PROGRESS_FILE" << EOF

## Progress Update: $TIMESTAMP
- **Action**: $DESCRIPTION
- **Command**: \`$COMMAND\`
- **Status**: $status
- **Details**: $details
- **Next Step**: $next_step

EOF
}

# Function to update current state section
update_current_state() {
    local status="$1"
    local next_step="$2"
    
    if [ ! -f "$PROGRESS_FILE" ]; then
        return
    fi
    
    # Check if Current State section exists
    if grep -q "## Current State" "$PROGRESS_FILE"; then
        # Update existing section
        sed -i.bak "/## Current State/,/## / {
            s/- \*\*Last Action Taken\*\*:.*/- **Last Action Taken**: $DESCRIPTION/
            s/- \*\*Next Immediate Step\*\*:.*/- **Next Immediate Step**: $next_step/
            s/- \*\*Last Updated\*\*:.*/- **Last Updated**: $TIMESTAMP/
        }" "$PROGRESS_FILE"
        rm "$PROGRESS_FILE.bak" 2>/dev/null || true
    fi
}

print_status "Executing: $DESCRIPTION"
print_status "Command: $COMMAND"

# Log the attempt
update_progress "IN_PROGRESS" "Command execution started" "Waiting for command completion"

# Create a temporary file to capture output
TEMP_OUTPUT=$(mktemp)
TEMP_ERROR=$(mktemp)

# Execute the command and capture both stdout and stderr
if eval "$COMMAND" > "$TEMP_OUTPUT" 2> "$TEMP_ERROR"; then
    # Command succeeded
    COMMAND_OUTPUT=$(cat "$TEMP_OUTPUT")
    COMMAND_ERROR=$(cat "$TEMP_ERROR")
    
    print_success "Command completed successfully"
    
    # Show output if not empty
    if [ -n "$COMMAND_OUTPUT" ]; then
        echo "Output:"
        echo "$COMMAND_OUTPUT"
    fi
    
    # Log success
    if [ -n "$COMMAND_OUTPUT" ]; then
        update_progress "COMPLETED" "Command executed successfully. Output: $COMMAND_OUTPUT" "Continue with next step"
    else
        update_progress "COMPLETED" "Command executed successfully (no output)" "Continue with next step"
    fi
    
    update_current_state "COMPLETED" "Continue with next step"
    
    # Update task progress in config if available
    if command -v get_config >/dev/null 2>&1; then
        current_task=$(get_config 'tasks.current' 2>/dev/null || echo "")
        if [ -n "$current_task" ]; then
            print_status "Current task: $current_task"
        fi
    fi
    
    exit_code=0
else
    # Command failed
    COMMAND_OUTPUT=$(cat "$TEMP_OUTPUT")
    COMMAND_ERROR=$(cat "$TEMP_ERROR")
    
    print_error "Command failed"
    
    # Show error output
    if [ -n "$COMMAND_ERROR" ]; then
        echo "Error output:"
        echo "$COMMAND_ERROR"
    fi
    
    if [ -n "$COMMAND_OUTPUT" ]; then
        echo "Standard output:"
        echo "$COMMAND_OUTPUT"
    fi
    
    # Log failure
    local error_details="Command failed."
    if [ -n "$COMMAND_ERROR" ]; then
        error_details="$error_details Error: $COMMAND_ERROR"
    fi
    if [ -n "$COMMAND_OUTPUT" ]; then
        error_details="$error_details Output: $COMMAND_OUTPUT"
    fi
    
    update_progress "FAILED" "$error_details" "Review error and retry or seek assistance"
    update_current_state "BLOCKED" "Review error and retry or seek assistance"
    
    exit_code=1
fi

# Clean up temporary files
rm -f "$TEMP_OUTPUT" "$TEMP_ERROR"

# Show final status
if [ $exit_code -eq 0 ]; then
    print_success "Task completed and logged to $PROGRESS_FILE"
else
    print_error "Task failed and logged to $PROGRESS_FILE"
fi

exit $exit_code
