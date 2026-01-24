#!/bin/bash

echo "⚙️ Setting up Zsh..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_DIR="$DOTFILES_DIR/zsh"

# Symlink .zshrc
ln -sf "$ZSH_DIR/.zshrc" ~/.zshrc

echo "✅ Zsh configured"
