#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
# Dotfiles Bootstrap Script
# One-click setup for fresh macOS: curl -fsSL .../bootstrap.sh | bash
# ═══════════════════════════════════════════════════════════════════════════

set -e

# Configuration
DOTFILES_DIR="${HOME}/dotfiles"
INTERACTIVE=false
GITHUB_REPO="https://github.com/tranxuanliem/dotfiles.git"

# ═══════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════

print_help() {
    cat << EOF
Usage: bootstrap.sh [OPTIONS]

One-click setup for fresh macOS with dotfiles installation.

OPTIONS:
  --interactive   Run setup wizard to customize configuration
  --dir PATH      Clone dotfiles to custom directory (default: ~/dotfiles)
  --help          Show this help message

EXAMPLES:
  # Basic setup with defaults
  curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash

  # Interactive setup wizard
  curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash -s -- --interactive

  # Custom installation directory
  curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash -s -- --dir ~/.config/dotfiles

WHAT IT DOES:
  1. Installs Xcode CLI tools (if needed)
  2. Clones dotfiles repo to ~/dotfiles
  3. Creates config.local with sensible defaults
  4. Runs the full installer

MORE INFO:
  See README.md in the cloned repo for details.
EOF
}

print_banner() {
    echo ""
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║              🚀 Dotfiles Bootstrap                            ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo ""
}

print_success() {
    echo ""
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║              ✅ Bootstrap Complete!                           ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════
# Argument Parsing
# ═══════════════════════════════════════════════════════════════════════════

while [[ $# -gt 0 ]]; do
    case $1 in
        --help)
            print_help
            exit 0
            ;;
        --interactive)
            INTERACTIVE=true
            shift
            ;;
        --dir)
            if [ -z "$2" ]; then
                echo "❌ Error: --dir requires a path argument"
                exit 1
            fi
            # Expand tilde to home directory
            DOTFILES_DIR="${2/#\~/$HOME}"
            shift 2
            ;;
        *)
            echo "❌ Unknown option: $1"
            print_help
            exit 1
            ;;
    esac
done

# ═══════════════════════════════════════════════════════════════════════════
# Step 1: Install Xcode CLI Tools
# ═══════════════════════════════════════════════════════════════════════════

print_banner

echo "📦 Checking Xcode CLI tools..."

if ! xcode-select -p &>/dev/null; then
    echo "   Installing Xcode CLI tools (this may take several minutes)..."
    echo "   👉 A dialog will appear asking for permission. Click 'Install' to continue."
    echo ""

    xcode-select --install

    # Wait for installation to complete
    echo "   Waiting for installation to complete..."
    max_attempts=360  # 30 minutes max
    attempt=0
    until xcode-select -p &>/dev/null; do
        attempt=$((attempt + 1))
        if [ $attempt -ge $max_attempts ]; then
            echo ""
            echo "❌ Error: Xcode CLI tools installation timed out after 30 minutes."
            echo "   Please install manually:"
            echo "   xcode-select --install"
            exit 1
        fi
        sleep 5
    done
    echo "   ✅ Xcode CLI tools installed"
else
    echo "   ✅ Xcode CLI tools already installed"
fi

echo ""

# ═══════════════════════════════════════════════════════════════════════════
# Step 2: Clone or Update Repository
# ═══════════════════════════════════════════════════════════════════════════

echo "📂 Setting up repository..."

if [ -d "$DOTFILES_DIR/.git" ]; then
    echo "   Dotfiles already cloned at $DOTFILES_DIR"
    echo "   Pulling latest changes..."
    git -C "$DOTFILES_DIR" pull --ff-only || {
        echo "   ⚠️  Could not pull latest changes (offline or local modifications)"
    }
    echo "   ✅ Repository ready"
else
    echo "   Cloning dotfiles to $DOTFILES_DIR..."

    # Create parent directory if it doesn't exist
    parent_dir="$(dirname "$DOTFILES_DIR")"
    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir" || {
            echo "❌ Error: Failed to create directory $parent_dir"
            echo "   Check permissions and try again."
            exit 1
        }
    fi

    git clone "$GITHUB_REPO" "$DOTFILES_DIR" || {
        echo "❌ Error: Failed to clone repository"
        echo "   Check your internet connection and try again."
        exit 1
    }
    echo "   ✅ Repository cloned"
fi

echo ""

# ═══════════════════════════════════════════════════════════════════════════
# Step 3: Setup Configuration
# ═══════════════════════════════════════════════════════════════════════════

CONFIG_FILE="$DOTFILES_DIR/config.local"

echo "⚙️  Setting up configuration..."

if [ ! -f "$CONFIG_FILE" ]; then
    if [ "$INTERACTIVE" = true ]; then
        echo "   Running interactive setup wizard..."
        bash "$DOTFILES_DIR/setup.sh"
    else
        echo "   Creating default configuration..."
        if [ ! -f "$DOTFILES_DIR/config.example" ]; then
            echo "❌ Error: config.example not found in $DOTFILES_DIR"
            exit 1
        fi
        cp -p "$DOTFILES_DIR/config.example" "$CONFIG_FILE"
        echo "   ✅ Default config created at $CONFIG_FILE"
        echo "   📝 Edit $CONFIG_FILE to customize settings"
    fi
else
    echo "   ✅ Configuration already exists at $CONFIG_FILE"
fi

echo ""

# ═══════════════════════════════════════════════════════════════════════════
# Step 4: Run the Main Installer
# ═══════════════════════════════════════════════════════════════════════════

echo "🔧 Running main installer..."
echo ""

bash "$DOTFILES_DIR/install.sh"

# ═══════════════════════════════════════════════════════════════════════════
# Done!
# ═══════════════════════════════════════════════════════════════════════════

print_success
