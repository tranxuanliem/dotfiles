#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
# Dotfiles Installer
# ═══════════════════════════════════════════════════════════════════════════

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$DOTFILES_DIR/config.local"

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              🚀 Dotfiles Installation                         ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check for config
if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚠️  No config.local found."
    echo "   Running setup wizard first..."
    echo ""
    bash "$DOTFILES_DIR/setup.sh"
fi

# Load config
source "$CONFIG_FILE"

echo "Installing with configuration:"
echo "  → User: $GIT_USER_NAME <$GIT_USER_EMAIL>"
echo "  → Editor: $DEFAULT_EDITOR"
echo "  → Node.js: $NODE_VERSION"
echo ""

# Export for child scripts
export GIT_USER_NAME GIT_USER_EMAIL DEFAULT_EDITOR NODE_VERSION
export INSTALL_DDEV INSTALL_ORBSTACK
export MACOS_SHOW_HIDDEN_FILES MACOS_DOCK_AUTOHIDE MACOS_FAST_KEY_REPEAT
export MACOS_TAP_TO_CLICK MACOS_SCREENSHOTS_LOCATION SSH_KEY_EMAIL

# Install order matters
installers=(
    "homebrew"
    "zsh"
    "git"
    "ssh"
    "mise"
    "starship"
    "cursor"
    "ghostty"
    "zed"
    "warp"
    "ddev"
    "macos"
)

for installer in "${installers[@]}"; do
    if [ -f "$DOTFILES_DIR/$installer/install.sh" ]; then
        echo ""
        bash "$DOTFILES_DIR/$installer/install.sh"
    fi
done

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              ✅ Installation Complete!                        ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Add SSH key to GitHub/Bitbucket:"
echo "     cat ~/.ssh/id_ed25519.pub"
echo "  3. Import Raycast settings manually"
echo "  4. Select Warp theme: Settings > Appearance > Themes"
echo ""
