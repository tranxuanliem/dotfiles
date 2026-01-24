#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATE=$(date +%Y%m%d)

echo "📦 Backing up dotfiles..."

# Cursor
mkdir -p "$DOTFILES_DIR/cursor"
cp ~/Library/Application\ Support/Cursor/User/settings.json "$DOTFILES_DIR/cursor/" 2>/dev/null
cp ~/Library/Application\ Support/Cursor/User/keybindings.json "$DOTFILES_DIR/cursor/" 2>/dev/null
cursor --list-extensions > "$DOTFILES_DIR/cursor/extensions.txt" 2>/dev/null

# Brewfile
brew bundle dump --file="$DOTFILES_DIR/homebrew/Brewfile" --force

# DDEV
cp ~/.ddev/global_config.yaml "$DOTFILES_DIR/ddev/" 2>/dev/null

# Commit
cd "$DOTFILES_DIR"
git add -A
git commit -m "Backup $DATE" 2>/dev/null
git push 2>/dev/null

echo "✅ Backup complete!"
