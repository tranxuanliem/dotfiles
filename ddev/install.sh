#!/bin/bash

echo "⚙️ Setting up DDEV..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# mkcert
mkcert -install 2>/dev/null

# Global config
mkdir -p ~/.ddev
[ -f "$DOTFILES_DIR/ddev/global_config.yaml" ] && cp "$DOTFILES_DIR/ddev/global_config.yaml" ~/.ddev/

echo "✅ DDEV configured"
