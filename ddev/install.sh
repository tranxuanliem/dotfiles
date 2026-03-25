#!/bin/bash

echo "⚙️ Setting up DDEV..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Skip if not enabled
if [ "$INSTALL_DDEV" = "false" ]; then
    echo "   Skipped (disabled in config)"
    exit 0
fi

# Ensure brew tools are in PATH
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# mkcert
command -v mkcert &>/dev/null && mkcert -install 2>/dev/null

# Global config
mkdir -p ~/.ddev
[ -f "$DOTFILES_DIR/ddev/global_config.yaml" ] && cp "$DOTFILES_DIR/ddev/global_config.yaml" ~/.ddev/

echo "✅ DDEV configured"
