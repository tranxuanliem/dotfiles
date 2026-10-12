#!/bin/bash
set -e

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

ZED_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zed"
mkdir -p "$ZED_CONFIG_DIR/themes"

source "$DOTFILES_DIR/lib/config.sh"

link_config "$DOTFILES_DIR/zed/settings.json" "$ZED_CONFIG_DIR/settings.json"
link_config "$DOTFILES_DIR/zed/keymap.json" "$ZED_CONFIG_DIR/keymap.json"
for theme_file in "$DOTFILES_DIR/zed/themes/"*.json; do
    [ -f "$theme_file" ] || continue
    link_config "$theme_file" "$ZED_CONFIG_DIR/themes/$(basename "$theme_file")"
done

echo "✅ Zed configured"
