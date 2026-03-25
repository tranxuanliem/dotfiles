#!/bin/bash

echo "⚙️ Setting up Ghostty..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Skip if not enabled
if [ "$INSTALL_GHOSTTY" = "false" ]; then
    echo "   Skipped (disabled in config)"
    exit 0
fi

mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config

echo "✅ Ghostty configured"
