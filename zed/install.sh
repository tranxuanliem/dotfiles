#!/bin/bash

echo "⚙️ Setting up Zed..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p ~/.config/zed
ln -sf "$DOTFILES_DIR/zed/settings.json" ~/.config/zed/settings.json
ln -sf "$DOTFILES_DIR/zed/keymap.json" ~/.config/zed/keymap.json

echo "✅ Zed configured"
