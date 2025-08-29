#!/bin/bash

# Configuration Utilities for Project Management System
# Usage: source config-utils.sh

CONFIG_FILE="project.json"

# Function to get a configuration value
# Usage: get_config "project.name"
get_config() {
    local key="$1"
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: $CONFIG_FILE not found" >&2
        return 1
    fi
    
    # Use jq to extract the value, fallback to basic parsing if jq not available
    if command -v jq >/dev/null 2>&1; then
        jq -r ".$key // empty" "$CONFIG_FILE" 2>/dev/null
    else
        # Basic fallback parsing (limited functionality)
        grep "\"${key##*.}\"" "$CONFIG_FILE" | sed 's/.*: *"\([^"]*\)".*/\1/' | head -1
    fi
}

# Function to set a configuration value
# Usage: set_config "project.name" "New Project Name"
set_config() {
    local key="$1"
    local value="$2"
    
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: $CONFIG_FILE not found" >&2
        return 1
    fi
    
    # Use jq to update the value if available
    if command -v jq >/dev/null 2>&1; then
        local temp_file=$(mktemp)
        jq ".$key = \"$value\"" "$CONFIG_FILE" > "$temp_file" && mv "$temp_file" "$CONFIG_FILE"
    else
        echo "Warning: jq not available, manual config editing required" >&2
        return 1
    fi
}

# Function to update task progress
# Usage: update_task_progress "TASK-02" 1
update_task_progress() {
    local current_task="$1"
    local completed_count="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M')
    
    set_config "tasks.current" "$current_task"
    set_config "tasks.completed" "$completed_count"
    set_config "tasks.lastUpdated" "$timestamp"
}

# Function to display current project info
show_project_info() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: $CONFIG_FILE not found" >&2
        return 1
    fi
    
    echo "=== Project Information ==="
    echo "Name: $(get_config 'project.name')"
    echo "Type: $(get_config 'project.type')"
    echo "Working Directory: $(get_config 'project.workingDirectory')"
    echo "Current Task: $(get_config 'tasks.current')"
    echo "Tasks Completed: $(get_config 'tasks.completed')/$(get_config 'tasks.total')"
    echo "Last Updated: $(get_config 'tasks.lastUpdated')"
    echo "=========================="
}

# Function to validate environment requirements
check_environment() {
    local errors=0
    
    echo "=== Environment Check ==="
    
    # Check Node.js if required
    local node_version=$(get_config 'environment.requirements.node')
    if [ "$node_version" != "null" ] && [ "$node_version" != "" ] && [ "$node_version" != "[NODE_VERSION]" ]; then
        if command -v node >/dev/null 2>&1; then
            local installed_node=$(node --version | sed 's/v//')
            echo "✓ Node.js: $installed_node (required: $node_version)"
        else
            echo "✗ Node.js: Not installed (required: $node_version)"
            errors=$((errors + 1))
        fi
    fi
    
    # Check Python if required
    local python_version=$(get_config 'environment.requirements.python')
    if [ "$python_version" != "null" ] && [ "$python_version" != "" ] && [ "$python_version" != "[PYTHON_VERSION]" ]; then
        if command -v python3 >/dev/null 2>&1; then
            local installed_python=$(python3 --version | sed 's/Python //')
            echo "✓ Python: $installed_python (required: $python_version)"
        else
            echo "✗ Python: Not installed (required: $python_version)"
            errors=$((errors + 1))
        fi
    fi
    
    # Check Docker if required
    local docker_version=$(get_config 'environment.requirements.docker')
    if [ "$docker_version" != "null" ] && [ "$docker_version" != "" ] && [ "$docker_version" != "[DOCKER_VERSION]" ]; then
        if command -v docker >/dev/null 2>&1; then
            local installed_docker=$(docker --version | sed 's/Docker version //' | sed 's/,.*//')
            echo "✓ Docker: $installed_docker (required: $docker_version)"
        else
            echo "✗ Docker: Not installed (required: $docker_version)"
            errors=$((errors + 1))
        fi
    fi
    
    echo "========================="
    
    if [ $errors -eq 0 ]; then
        echo "✓ All environment requirements satisfied"
        return 0
    else
        echo "✗ $errors environment requirement(s) not met"
        return 1
    fi
}

# Function to initialize a new project config
init_project_config() {
    local project_name="$1"
    local project_dir="$2"
    local project_type="${3:-general}"
    
    if [ -f "$CONFIG_FILE" ]; then
        echo "Warning: $CONFIG_FILE already exists"
        return 1
    fi
    
    # Copy template and replace basic values
    local template_dir="$(dirname "$0")"
    cp "$template_dir/config.template.json" "$CONFIG_FILE"
    
    # Replace basic placeholders
    local current_date=$(date '+%Y-%m-%d')
    local current_datetime=$(date '+%Y-%m-%d %H:%M')
    
    sed -i.bak "s|\[PROJECT_NAME\]|$project_name|g" "$CONFIG_FILE"
    sed -i.bak "s|\[PROJECT_TYPE\]|$project_type|g" "$CONFIG_FILE"
    sed -i.bak "s|\[CREATION_DATE\]|$current_date|g" "$CONFIG_FILE"
    sed -i.bak "s|\[WORKING_DIRECTORY\]|$project_dir|g" "$CONFIG_FILE"
    sed -i.bak "s|\[LAST_UPDATE\]|$current_datetime|g" "$CONFIG_FILE"
    
    # Clean up backup file
    rm "$CONFIG_FILE.bak" 2>/dev/null || true
    
    echo "✓ Project configuration initialized: $CONFIG_FILE"
}
