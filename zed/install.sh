#!/bin/bash

echo "⚙️ Setting up Zed..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Skip if not enabled
if [ "$INSTALL_ZED" = "false" ]; then
    echo "   Skipped (disabled in config)"
    exit 0
fi

mkdir -p ~/.config/zed
ln -sf "$DOTFILES_DIR/zed/settings.json" ~/.config/zed/settings.json
ln -sf "$DOTFILES_DIR/zed/keymap.json" ~/.config/zed/keymap.json

echo "✅ Zed configured"
