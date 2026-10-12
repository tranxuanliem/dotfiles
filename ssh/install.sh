#!/bin/bash
set -e

echo "⚙️ Setting up SSH..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Retain this machine's host entries, identity files and connection settings.
if [ ! -e "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
    cp "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
else
    echo "   Existing SSH config retained; merge ssh/config manually if needed."
fi

# Generate key if needed
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "🔑 Generating SSH key..."

    # Use config email or prompt
    email="${SSH_KEY_EMAIL:-$GIT_USER_EMAIL}"
    if [ -z "$email" ]; then
        read -p "   Enter your email for SSH key: " email
    fi

    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 2>/dev/null

    echo ""
    echo "📋 Your public key (add to GitHub/Bitbucket):"
    echo "─────────────────────────────────────────────"
    cat ~/.ssh/id_ed25519.pub
    echo "─────────────────────────────────────────────"
fi

echo "✅ SSH configured"
