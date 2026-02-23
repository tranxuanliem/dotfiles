#!/bin/bash

echo "⚙️ Setting up Git..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_DIR="$DOTFILES_DIR/git"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Use config or prompt for values
if [ -z "$GIT_USER_NAME" ]; then
    read -p "   Git username: " GIT_USER_NAME
fi
if [ -z "$GIT_USER_EMAIL" ]; then
    read -p "   Git email: " GIT_USER_EMAIL
fi

# Determine editor (--wait only for GUI editors)
case "${DEFAULT_EDITOR:-cursor}" in
    vim|nvim|nano) EDITOR_CMD="${DEFAULT_EDITOR}" ;;
    *) EDITOR_CMD="${DEFAULT_EDITOR:-cursor} --wait" ;;
esac

# Create .gitconfig from template
cat > ~/.gitconfig << EOF
[user]
    name = $GIT_USER_NAME
    email = $GIT_USER_EMAIL

[init]
    defaultBranch = main

[core]
    editor = $EDITOR_CMD
    autocrlf = input
    ignorecase = false
    excludesfile = ~/.gitignore_global

[pull]
    rebase = true

[push]
    autoSetupRemote = true

[fetch]
    prune = true

[diff]
    algorithm = histogram

[merge]
    conflictstyle = diff3

[alias]
    co = checkout
    br = branch
    ci = commit
    st = status -sb
    lg = log --oneline --graph -15
    undo = reset HEAD~1 --mixed
    amend = commit --amend --no-edit
    last = log -1 HEAD

[color]
    ui = auto
EOF

# Symlink global gitignore
ln -sf "$GIT_DIR/.gitignore_global" ~/.gitignore_global

echo "✅ Git configured for $GIT_USER_NAME <$GIT_USER_EMAIL>"
