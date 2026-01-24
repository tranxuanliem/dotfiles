#!/bin/bash

echo "⚙️ Setting up Warp..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p ~/.warp/themes
cp "$DOTFILES_DIR/warp/"*.yaml ~/.warp/themes/ 2>/dev/null

echo "✅ Warp configured"
echo "   Note: Open Warp > Settings > Appearance > Themes to select the theme"
