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

# mkcert
command -v mkcert &>/dev/null && mkcert -install 2>/dev/null

# Global config
mkdir -p ~/.ddev
[ -f "$DOTFILES_DIR/ddev/global_config.yaml" ] && cp "$DOTFILES_DIR/ddev/global_config.yaml" ~/.ddev/

echo "✅ DDEV configured"
