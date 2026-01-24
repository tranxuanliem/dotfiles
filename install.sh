#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing dotfiles..."
echo ""

# Install order matters
installers=(
    "homebrew"
    "zsh"
    "git"
    "ssh"
    "mise"
    "starship"
    "cursor"
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
echo "✅ All done!"
echo ""
echo "Next steps:"
echo "  1. Restart terminal"
echo "  2. Add SSH key to GitHub/Bitbucket"
echo "  3. Import Raycast settings manually"
