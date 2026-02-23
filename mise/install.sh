#!/bin/bash

echo "⚙️ Setting up Mise..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

NODE_VERSION="${NODE_VERSION:-20}"

# Ensure brew binaries are in PATH (mise installed via Homebrew)
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v mise &> /dev/null; then
    echo "⚠️  mise not found. Install it first: brew install mise"
    exit 0
fi

eval "$(mise activate bash)"
mise use --global "node@$NODE_VERSION"

echo "✅ Mise configured (Node.js $NODE_VERSION)"
