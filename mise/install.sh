#!/bin/bash

echo "⚙️ Setting up Mise..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

NODE_VERSION="${NODE_VERSION:-20}"

eval "$(mise activate bash)"
mise use --global "node@$NODE_VERSION"

echo "✅ Mise configured (Node.js $NODE_VERSION)"
