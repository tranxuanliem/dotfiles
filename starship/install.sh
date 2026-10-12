#!/bin/bash
set -e

echo "⚙️ Setting up Starship..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$DOTFILES_DIR/lib/config.sh"
link_config "$DOTFILES_DIR/starship/starship.toml" "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"

echo "✅ Starship configured"
