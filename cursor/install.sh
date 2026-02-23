#!/bin/bash

echo "⚙️ Setting up Cursor..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CURSOR_DIR="$DOTFILES_DIR/cursor"
CURSOR_USER_DIR=~/Library/Application\ Support/Cursor/User

# Create directory
mkdir -p "$CURSOR_USER_DIR"

# Copy settings
cp "$CURSOR_DIR/settings.json" "$CURSOR_USER_DIR/"
[ -f "$CURSOR_DIR/keybindings.json" ] && cp "$CURSOR_DIR/keybindings.json" "$CURSOR_USER_DIR/"

# Install extensions (requires Cursor CLI - install from Command Palette: "Install 'cursor' command in PATH")
if [ -f "$CURSOR_DIR/extensions.txt" ]; then
    if command -v cursor &> /dev/null; then
        echo "📦 Installing extensions..."
        while read extension; do
            cursor --install-extension "$extension" --force
        done < "$CURSOR_DIR/extensions.txt"
    else
        echo "⚠️  Cursor CLI not found. Open Cursor → Command Palette → 'Install cursor command in PATH', then re-run."
    fi
fi

echo "✅ Cursor configured"
