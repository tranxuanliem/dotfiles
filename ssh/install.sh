#!/bin/bash

echo "⚙️ Setting up SSH..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copy config (not symlink to allow local additions)
[ -f "$DOTFILES_DIR/ssh/config" ] && cp "$DOTFILES_DIR/ssh/config" ~/.ssh/config
chmod 600 ~/.ssh/config 2>/dev/null

# Generate key if needed
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "🔑 Generating SSH key..."
    read -p "Enter your email: " email
    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo ""
    echo "📋 Your public key:"
    cat ~/.ssh/id_ed25519.pub
fi

echo "✅ SSH configured"
