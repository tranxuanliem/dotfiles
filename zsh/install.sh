#!/bin/bash
set -e

echo "⚙️ Setting up Zsh..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_DIR="$DOTFILES_DIR/zsh"

# Symlink .zshrc
source "$DOTFILES_DIR/lib/config.sh"
link_config "$ZSH_DIR/.zshrc" "$HOME/.zshrc"

echo "✅ Zsh configured"
