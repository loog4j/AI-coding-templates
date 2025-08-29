#!/bin/bash

# Security Analysis Script
# Usage: ./security-check.sh [project-directory]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[SECURITY]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SECURITY]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[SECURITY]${NC} $1"
}

print_error() {
    echo -e "${RED}[SECURITY]${NC} $1"
}

# Get project directory (default to current directory)
PROJECT_DIR="${1:-.}"
SCRIPT_DIR="$(dirname "$0")"
SECURITY_DIR="$PROJECT_DIR/security"
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
ANALYSIS_FILE="$SECURITY_DIR/SECURITY-ANALYSIS-$TIMESTAMP.md"

print_status "Starting security analysis for project in: $PROJECT_DIR"

# Create security directory if it doesn't exist
if [ ! -d "$SECURITY_DIR" ]; then
    print_status "Creating security directory..."
    mkdir -p "$SECURITY_DIR"
fi

# Source config utilities if available
if [ -f "$PROJECT_DIR/scripts/config-utils.sh" ]; then
    source "$PROJECT_DIR/scripts/config-utils.sh"
    CONFIG_AVAILABLE=true
else
    CONFIG_AVAILABLE=false
fi

# Get project information
if [ "$CONFIG_AVAILABLE" = true ] && [ -f "$PROJECT_DIR/project.json" ]; then
    PROJECT_NAME=$(get_config 'project.name' 2>/dev/null || echo "Unknown Project")
    PROJECT_TYPE=$(get_config 'project.type' 2>/dev/null || echo "Unknown")
    TECH_STACK=$(get_config 'technology.stack' 2>/dev/null || echo "Unknown")
else
    # Fallback to directory name if config not available
    PROJECT_NAME=$(basename "$PROJECT_DIR")
    PROJECT_TYPE="Unknown"
    TECH_STACK="Unknown"
fi

CURRENT_DATE=$(date '+%Y-%m-%d %H:%M')
ANALYST_NAME=$(whoami)

print_status "Creating security analysis report: $ANALYSIS_FILE"

# Copy template and customize
if [ -f "$SCRIPT_DIR/templates/SECURITY_ANALYSIS_TEMPLATE.md" ]; then
    # Running from within a project (template is in scripts/templates/)
    cp "$SCRIPT_DIR/templates/SECURITY_ANALYSIS_TEMPLATE.md" "$ANALYSIS_FILE"
elif [ -f "$SCRIPT_DIR/../templates/security/SECURITY_ANALYSIS_TEMPLATE.md" ]; then
    # Running from template directory (template is in ../templates/security/)
    cp "$SCRIPT_DIR/../templates/security/SECURITY_ANALYSIS_TEMPLATE.md" "$ANALYSIS_FILE"
else
    print_error "Security analysis template not found!"
    print_error "Expected locations:"
    print_error "  - $SCRIPT_DIR/templates/SECURITY_ANALYSIS_TEMPLATE.md"
    print_error "  - $SCRIPT_DIR/../templates/security/SECURITY_ANALYSIS_TEMPLATE.md"
    print_error "Available files in $SCRIPT_DIR/templates/:"
    ls -la "$SCRIPT_DIR/templates/" 2>/dev/null || echo "Directory not found"
    exit 1
fi

# Replace placeholders
sed -i.bak "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" "$ANALYSIS_FILE"
sed -i.bak "s/\[YYYY-MM-DD HH:MM\]/$CURRENT_DATE/g" "$ANALYSIS_FILE"
sed -i.bak "s/\[PROJECT_TYPE\]/$PROJECT_TYPE/g" "$ANALYSIS_FILE"
sed -i.bak "s/\[TECH_STACK\]/$TECH_STACK/g" "$ANALYSIS_FILE"
sed -i.bak "s/\[ANALYST_NAME\]/$ANALYST_NAME/g" "$ANALYSIS_FILE"

# Clean up backup file
rm "$ANALYSIS_FILE.bak" 2>/dev/null || true

print_success "Security analysis template created successfully!"
print_status "File location: $ANALYSIS_FILE"
print_status ""
print_status "=== SECURITY ANALYSIS INSTRUCTIONS ==="
print_status "1. Open the generated security analysis file"
print_status "2. Review each section and fill in the analysis"
print_status "3. Use the AI model to help analyze the current security state"
print_status "4. Generate threat models based on the project architecture"
print_status "5. Prioritize recommendations using the decision matrix"
print_status "6. Update PROGRESS.md with security analysis completion"
print_status ""
print_warning "Remember: This is a template. The AI model should perform the actual analysis!"

# Create a summary for PROGRESS.md if it exists
if [ -f "$PROJECT_DIR/PROGRESS.md" ]; then
    print_status "Updating PROGRESS.md with security analysis entry..."
    cat >> "$PROJECT_DIR/PROGRESS.md" << EOF

## Security Analysis Initiated: $CURRENT_DATE
- **Analysis File**: $ANALYSIS_FILE
- **Status**: Template created, analysis pending
- **Next Step**: AI model should analyze project security and populate the template
- **Analyst**: $ANALYST_NAME

EOF
    print_success "PROGRESS.md updated with security analysis entry"
fi

# Provide AI-specific instructions
cat << EOF

=== AI MODEL INSTRUCTIONS ===
To complete this security analysis, the AI model should:

1. **Examine the project structure** in $PROJECT_DIR
2. **Read configuration files** (package.json, requirements.txt, etc.)
3. **Analyze source code** for security patterns and vulnerabilities
4. **Review dependencies** for known security issues
5. **Assess architecture** based on project files and documentation
6. **Populate the template** with specific findings and recommendations
7. **Create a threat model** relevant to this project type
8. **Prioritize recommendations** based on risk and effort

The AI should replace all [PLACEHOLDER] values with actual analysis results.

Security Analysis File: $ANALYSIS_FILE
Project Directory: $PROJECT_DIR
Project Type: $PROJECT_TYPE
Technology Stack: $TECH_STACK

EOF

print_success "Security analysis setup complete!"
print_status "Next: Have your AI model analyze the project and populate the security report."

# Return the path to the analysis file for potential automation
echo "$ANALYSIS_FILE"
