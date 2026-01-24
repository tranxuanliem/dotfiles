#!/bin/bash

echo "⚙️ Setting up Git..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_DIR="$DOTFILES_DIR/git"

# Symlinks
ln -sf "$GIT_DIR/.gitconfig" ~/.gitconfig
ln -sf "$GIT_DIR/.gitignore_global" ~/.gitignore_global

# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo "✅ Git configured"
