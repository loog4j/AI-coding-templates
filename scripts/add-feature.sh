#!/bin/bash

# Add Feature Request Script
# Usage: ./add-feature.sh "Brief description of the feature"

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
    print_error "Usage: $0 \"Brief description of the feature\""
    print_error "Example: $0 \"Add dark mode toggle to user settings\""
    exit 1
fi

FEATURE_DESCRIPTION="$1"
SCRIPT_DIR="$(dirname "$0")"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
FEATURES_DIR="$PROJECT_ROOT/features"
TEMPLATES_DIR="$SCRIPT_DIR/templates"

# Create features directory if it doesn't exist
if [ ! -d "$FEATURES_DIR" ]; then
    print_status "Creating features directory..."
    mkdir -p "$FEATURES_DIR"
fi

# Generate timestamp for unique filename
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
FEATURE_FILENAME="FEATURE-$TIMESTAMP.md"
FEATURE_FILEPATH="$FEATURES_DIR/$FEATURE_FILENAME"

# Check if template exists
TEMPLATE_PATH="$TEMPLATES_DIR/FEATURE_REQUEST_TEMPLATE.md"
if [ ! -f "$TEMPLATE_PATH" ]; then
    print_error "Feature request template not found at: $TEMPLATE_PATH"
    print_error "Please ensure the template file exists in the scripts/templates/ directory"
    exit 1
fi

print_status "Creating new feature request: $FEATURE_FILENAME"

# Copy template and customize
cp "$TEMPLATE_PATH" "$FEATURE_FILEPATH"

# Replace placeholders in the new file
CURRENT_DATE=$(date '+%Y-%m-%d')
CURRENT_USER=$(whoami)

# Use sed to replace placeholders
sed -i.bak "s/\[TIMESTAMP\]/$TIMESTAMP/g" "$FEATURE_FILEPATH"
sed -i.bak "s/\[Feature Title\]/$FEATURE_DESCRIPTION/g" "$FEATURE_FILEPATH"
sed -i.bak "s/\[YYYY-MM-DD\]/$CURRENT_DATE/g" "$FEATURE_FILEPATH"
sed -i.bak "s/\[Name\/Username\]/$CURRENT_USER/g" "$FEATURE_FILEPATH"

# Clean up backup file
rm "$FEATURE_FILEPATH.bak" 2>/dev/null || true

print_success "Feature request created successfully!"
print_status "File location: $FEATURE_FILEPATH"
print_status ""
print_status "Next steps:"
print_status "1. Edit the feature request file to add details"
print_status "2. Fill in the user story, use cases, and acceptance criteria"
print_status "3. Set the priority level (High/Medium/Low)"
print_status "4. Add technical considerations and implementation notes"
print_status "5. Define success metrics and validation criteria"
print_status ""
print_warning "Don't forget to update PROGRESS.md with this new feature request!"

# Optionally open the file in the default editor (uncomment if desired)
# if command -v code >/dev/null 2>&1; then
#     print_status "Opening feature request in VS Code..."
#     code "$FEATURE_FILEPATH"
# elif command -v nano >/dev/null 2>&1; then
#     print_status "Opening feature request in nano..."
#     nano "$FEATURE_FILEPATH"
# fi

echo ""
echo "Feature request summary:"
echo "========================"
echo "ID: FEATURE-$TIMESTAMP"
echo "Title: $FEATURE_DESCRIPTION"
echo "Date: $CURRENT_DATE"
echo "Requester: $CURRENT_USER"
echo "File: $FEATURE_FILEPATH"
