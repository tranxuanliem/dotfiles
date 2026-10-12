#!/bin/bash
set -e

echo "⚙️ Setting up Warp..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p ~/.warp/themes
source "$DOTFILES_DIR/lib/config.sh"
for theme_file in "$DOTFILES_DIR/warp/"*.yaml; do
    [ -f "$theme_file" ] || continue
    copy_config "$theme_file" "$HOME/.warp/themes/$(basename "$theme_file")"
done

echo "✅ Warp configured"
echo "   Note: Open Warp > Settings > Appearance > Themes to select the theme"
