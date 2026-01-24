#!/bin/bash

echo "⚙️ Setting up Mise..."

eval "$(mise activate bash)"
mise use --global node@20

echo "✅ Mise configured"
