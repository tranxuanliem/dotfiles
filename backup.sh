#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATE=$(date +%Y%m%d)

echo "📦 Backing up dotfiles..."

# ===== Cursor =====
echo "  → Cursor settings & extensions..."
mkdir -p "$DOTFILES_DIR/cursor"
cp ~/Library/Application\ Support/Cursor/User/settings.json "$DOTFILES_DIR/cursor/" 2>/dev/null
cp ~/Library/Application\ Support/Cursor/User/keybindings.json "$DOTFILES_DIR/cursor/" 2>/dev/null
cursor --list-extensions > "$DOTFILES_DIR/cursor/extensions.txt" 2>/dev/null

# ===== Ghostty =====
echo "  → Ghostty config..."
mkdir -p "$DOTFILES_DIR/ghostty"
cp ~/.config/ghostty/config "$DOTFILES_DIR/ghostty/" 2>/dev/null

# ===== Zed =====
echo "  → Zed settings & keymap..."
mkdir -p "$DOTFILES_DIR/zed"
cp ~/.config/zed/settings.json "$DOTFILES_DIR/zed/" 2>/dev/null
cp ~/.config/zed/keymap.json "$DOTFILES_DIR/zed/" 2>/dev/null

# ===== Starship =====
echo "  → Starship config..."
mkdir -p "$DOTFILES_DIR/starship"
cp ~/.config/starship.toml "$DOTFILES_DIR/starship/" 2>/dev/null

# ===== Warp =====
echo "  → Warp themes..."
mkdir -p "$DOTFILES_DIR/warp"
cp ~/.warp/themes/*.yaml "$DOTFILES_DIR/warp/" 2>/dev/null

# ===== Brewfile =====
echo "  → Homebrew packages..."
brew bundle dump --file="$DOTFILES_DIR/homebrew/Brewfile" --force

# ===== DDEV =====
echo "  → DDEV global config..."
cp ~/.ddev/global_config.yaml "$DOTFILES_DIR/ddev/" 2>/dev/null

# ===== Git Commit =====
echo ""
echo "📤 Committing changes..."
cd "$DOTFILES_DIR"
git add -A
git commit -m "Backup $DATE" 2>/dev/null || echo "   No changes to commit"
git push 2>/dev/null || echo "   Push skipped (no remote or already up to date)"

echo ""
echo "✅ Backup complete!"
