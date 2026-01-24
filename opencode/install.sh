#!/bin/bash

echo "⚙️ Setting up OpenCode..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OPENCODE_DIR="$DOTFILES_DIR/opencode"
CONFIG_DIR="$HOME/.config/opencode"

# Create config directory
mkdir -p "$CONFIG_DIR/themes"

# Symlink config files
ln -sf "$OPENCODE_DIR/opencode.json" "$CONFIG_DIR/opencode.json"
ln -sf "$OPENCODE_DIR/.ckignore" "$CONFIG_DIR/.ckignore"

# Symlink theme
ln -sf "$OPENCODE_DIR/themes/one-dark-pro-night-flat.json" "$CONFIG_DIR/themes/one-dark-pro-night-flat.json"

echo "✅ OpenCode configured"
echo "   Theme: One Dark Pro Night Flat"
echo "   Config: ~/.config/opencode/opencode.json"
