#!/bin/bash

echo "⚙️ Setting up Cursor..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CURSOR_DIR="$DOTFILES_DIR/cursor"
CURSOR_USER_DIR=~/Library/Application\ Support/Cursor/User

# Create directory
mkdir -p "$CURSOR_USER_DIR"

# Copy settings
cp "$CURSOR_DIR/settings.json" "$CURSOR_USER_DIR/"
[ -f "$CURSOR_DIR/keybindings.json" ] && cp "$CURSOR_DIR/keybindings.json" "$CURSOR_USER_DIR/"

# Install extensions
if [ -f "$CURSOR_DIR/extensions.txt" ]; then
    # Try common Cursor CLI locations
    CURSOR_CLI=""
    if command -v cursor &> /dev/null; then
        CURSOR_CLI="cursor"
    elif [ -f "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ]; then
        CURSOR_CLI="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
    fi

    if [ -n "$CURSOR_CLI" ]; then
        echo "📦 Installing extensions..."
        while IFS= read -r extension || [ -n "$extension" ]; do
            extension=$(echo "$extension" | xargs)
            [ -z "$extension" ] && continue
            [[ "$extension" == \#* ]] && continue
            "$CURSOR_CLI" --install-extension "$extension" --force
        done < "$CURSOR_DIR/extensions.txt"
    else
        echo "⚠️  Cursor CLI not found. Open Cursor → Command Palette → 'Install cursor command in PATH', then re-run:"
        echo "     bash ~/dotfiles/cursor/install.sh"
    fi
fi

echo "✅ Cursor configured"
