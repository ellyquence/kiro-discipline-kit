#!/bin/bash
#
# Kiro Global Profile Installer
# Installs the .kiro configuration to a target project directory
#
# Usage:
#   ./install-kiro-profile.sh [target-directory]
#   ./install-kiro-profile.sh                    # Installs to current directory
#   ./install-kiro-profile.sh /path/to/project   # Installs to specified project
#
# Options:
#   --global    Install to ~/.config/kiro/ for user-wide defaults (experimental)
#   --symlink   Create symlinks instead of copying (for version-controlled config)
#   --force     Overwrite existing .kiro directory
#   --help      Show this help message

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_KIRO="$SCRIPT_DIR/.kiro"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}→${NC} $1"; }

show_help() {
    head -20 "$0" | tail -18
    exit 0
}

# Parse arguments
TARGET_DIR="."
USE_SYMLINKS=false
FORCE=false
GLOBAL_INSTALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --global)
            GLOBAL_INSTALL=true
            TARGET_DIR="$HOME/.config/kiro"
            shift
            ;;
        --symlink)
            USE_SYMLINKS=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --help|-h)
            show_help
            ;;
        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

# Validate source exists
if [ ! -d "$SOURCE_KIRO" ]; then
    print_error "Source .kiro directory not found at: $SOURCE_KIRO"
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"
TARGET_KIRO="$TARGET_DIR/.kiro"

# Check for existing installation
if [ -d "$TARGET_KIRO" ]; then
    if [ "$FORCE" = true ]; then
        print_warning "Removing existing .kiro directory..."
        rm -rf "$TARGET_KIRO"
    else
        print_error ".kiro directory already exists at: $TARGET_KIRO"
        print_info "Use --force to overwrite"
        exit 1
    fi
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║           Kiro Global Profile Installer                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Source: $SOURCE_KIRO"
print_info "Target: $TARGET_KIRO"
print_info "Method: $([ "$USE_SYMLINKS" = true ] && echo "Symlinks" || echo "Copy")"
echo ""

if [ "$USE_SYMLINKS" = true ]; then
    # Create symlink
    ln -s "$SOURCE_KIRO" "$TARGET_KIRO"
    print_success "Created symlink: $TARGET_KIRO -> $SOURCE_KIRO"
else
    # Copy the directory
    cp -r "$SOURCE_KIRO" "$TARGET_KIRO"
    print_success "Copied .kiro configuration"
fi

# Verify installation
echo ""
echo "Installation complete! Verifying..."
echo ""

# Count files
STEERING_COUNT=$(find "$TARGET_KIRO/steering" -name "*.md" 2>/dev/null | wc -l)
HOOKS_COUNT=$(find "$TARGET_KIRO/hooks" -name "*.kiro.hook" 2>/dev/null | wc -l)
TEMPLATES_COUNT=$(find "$TARGET_KIRO/templates" -name "*.md" 2>/dev/null | wc -l)

echo "📁 Installed:"
echo "   ├── steering/     ($STEERING_COUNT files)"
echo "   ├── hooks/        ($HOOKS_COUNT hooks)"
echo "   ├── templates/    ($TEMPLATES_COUNT templates)"
echo "   ├── settings/     (mcp.json)"
echo "   └── specs/        (ready for specs)"
echo ""

if [ "$GLOBAL_INSTALL" = true ]; then
    print_warning "Global installation is experimental."
    print_info "Kiro may not automatically load from ~/.config/kiro/"
    print_info "Consider using symlinks in each project instead."
fi

echo ""
print_success "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Open the project in Kiro IDE"
echo "  2. Restart Kiro to activate hooks"
echo "  3. Run 'Kiro: New Spec' to create your first spec"
echo ""
