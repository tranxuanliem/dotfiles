#!/bin/bash
# Install One Dark Pro Night Flat theme for macOS Terminal.app

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_FILE="$SCRIPT_DIR/OneDarkProNightFlat.terminal"
PROFILE_NAME="One Dark Pro Night Flat"
TERMINAL_PREFS="$HOME/Library/Preferences/com.apple.Terminal.plist"

echo "=== Terminal.app Theme ==="

# Regenerate theme if Swift script exists
if [[ -f "$SCRIPT_DIR/generate-theme.swift" ]]; then
    echo "Generating theme..."
    swift "$SCRIPT_DIR/generate-theme.swift" > /dev/null 2>&1
fi

# Check if theme file exists
if [[ ! -f "$THEME_FILE" ]]; then
    echo "⚠️  Theme file not found, skipping"
    exit 0
fi

# Close Terminal preferences cache
defaults read com.apple.Terminal > /dev/null 2>&1

# Import profile using PlistBuddy
echo "Importing Terminal profile..."
if /usr/libexec/PlistBuddy -c "Delete ':Window Settings:$PROFILE_NAME'" "$TERMINAL_PREFS" 2>/dev/null; then
    echo "  Removed existing profile"
fi
/usr/libexec/PlistBuddy -c "Merge '$THEME_FILE' ':Window Settings:$PROFILE_NAME'" "$TERMINAL_PREFS" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add ':Window Settings:$PROFILE_NAME' dict" "$TERMINAL_PREFS" 2>/dev/null

# Alternative: copy all keys from theme file
if ! /usr/libexec/PlistBuddy -c "Print ':Window Settings:$PROFILE_NAME:name'" "$TERMINAL_PREFS" 2>/dev/null; then
    # Merge didn't work, try plutil approach
    echo "  Using plutil merge..."
    plutil -replace "Window Settings.$PROFILE_NAME" -xml "$(cat "$THEME_FILE")" "$TERMINAL_PREFS" 2>/dev/null || \
    open "$THEME_FILE"  # Fallback: let Terminal import it
    sleep 1
fi

# Set as default profile
echo "Setting as default profile..."
defaults write com.apple.Terminal "Default Window Settings" -string "$PROFILE_NAME"
defaults write com.apple.Terminal "Startup Window Settings" -string "$PROFILE_NAME"

echo "✅ Terminal.app theme installed"
echo "   Profile: $PROFILE_NAME"
