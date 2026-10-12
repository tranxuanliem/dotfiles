#!/bin/bash
set -e

echo "⚙️ Setting up Ghostty..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ ! -f "$DOTFILES_DIR/config.local" ] || source "$DOTFILES_DIR/config.local"
source "$DOTFILES_DIR/lib/config.sh"
if [ "${INSTALL_GHOSTTY:-true}" = "false" ]; then
    echo "   Skipped (disabled in config)"
    exit 0
fi
link_config "$DOTFILES_DIR/ghostty/config" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
# macOS also reads this directory after XDG config. Link both to avoid conflicting palettes.
if [ "$(uname -s)" = "Darwin" ]; then
    link_config "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
fi
echo "✅ Ghostty configured"
