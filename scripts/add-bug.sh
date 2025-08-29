#!/bin/bash

# Add Bug Report Script
# Usage: ./add-bug.sh "Brief description of the bug"

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

# Check if description is provided
if [ $# -eq 0 ]; then
    print_error "Usage: $0 \"Brief description of the bug\""
    print_error "Example: $0 \"Login button not working on mobile\""
    exit 1
fi

BUG_DESCRIPTION="$1"
SCRIPT_DIR="$(dirname "$0")"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUGS_DIR="$PROJECT_ROOT/bugs"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# Create bugs directory if it doesn't exist
if [ ! -d "$BUGS_DIR" ]; then
    print_status "Creating bugs directory..."
    mkdir -p "$BUGS_DIR"
fi

# Generate timestamp for unique filename
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
BUG_FILENAME="BUG-$TIMESTAMP.md"
BUG_FILEPATH="$BUGS_DIR/$BUG_FILENAME"

# Check if template exists
TEMPLATE_PATH="$TEMPLATES_DIR/BUG_REPORT_TEMPLATE.md"
if [ ! -f "$TEMPLATE_PATH" ]; then
    print_error "Bug report template not found at: $TEMPLATE_PATH"
    print_error "Please ensure the template file exists in the scripts/templates/ directory"
    exit 1
fi

print_status "Creating new bug report: $BUG_FILENAME"

# Copy template and customize
cp "$TEMPLATE_PATH" "$BUG_FILEPATH"

# Replace placeholders in the new file
CURRENT_DATE=$(date '+%Y-%m-%d')
CURRENT_USER=$(whoami)

# Use sed to replace placeholders
sed -i.bak "s/\[TIMESTAMP\]/$TIMESTAMP/g" "$BUG_FILEPATH"
sed -i.bak "s/\[Bug Title\]/$BUG_DESCRIPTION/g" "$BUG_FILEPATH"
sed -i.bak "s/\[YYYY-MM-DD\]/$CURRENT_DATE/g" "$BUG_FILEPATH"
sed -i.bak "s/\[Name\/Username\]/$CURRENT_USER/g" "$BUG_FILEPATH"

# Clean up backup file
rm "$BUG_FILEPATH.bak" 2>/dev/null || true

print_success "Bug report created successfully!"
print_status "File location: $BUG_FILEPATH"
print_status ""
print_status "Next steps:"
print_status "1. Edit the bug report file to add details"
print_status "2. Fill in the steps to reproduce, expected behavior, etc."
print_status "3. Update the severity level (Critical/High/Medium/Low)"
print_status "4. Add any screenshots or logs to the appropriate section"
print_status ""
print_warning "Don't forget to update PROGRESS.md with this new bug report!"

# Optionally open the file in the default editor (uncomment if desired)
# if command -v code >/dev/null 2>&1; then
#     print_status "Opening bug report in VS Code..."
#     code "$BUG_FILEPATH"
# elif command -v nano >/dev/null 2>&1; then
#     print_status "Opening bug report in nano..."
#     nano "$BUG_FILEPATH"
# fi

echo ""
echo "Bug report summary:"
echo "==================="
echo "ID: BUG-$TIMESTAMP"
echo "Title: $BUG_DESCRIPTION"
echo "Date: $CURRENT_DATE"
echo "Reporter: $CURRENT_USER"
echo "File: $BUG_FILEPATH"
