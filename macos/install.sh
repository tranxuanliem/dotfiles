#!/bin/bash

echo "⚙️ Applying macOS settings..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# ===== Finder =====
if [ "$MACOS_SHOW_HIDDEN_FILES" = "true" ]; then
    defaults write com.apple.finder AppleShowAllFiles -bool true
    echo "   → Show hidden files: enabled"
fi

# Always enable these useful Finder settings
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ===== Dock =====
if [ "$MACOS_DOCK_AUTOHIDE" = "true" ]; then
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0.3
    echo "   → Dock auto-hide: enabled"
fi
defaults write com.apple.dock show-recents -bool false

# ===== Keyboard =====
if [ "$MACOS_FAST_KEY_REPEAT" = "true" ]; then
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    echo "   → Fast key repeat: enabled"
fi

# Disable auto-correct (always, for developers)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ===== Trackpad =====
if [ "$MACOS_TAP_TO_CLICK" = "true" ]; then
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    echo "   → Tap to click: enabled"
fi

# ===== Screenshots =====
SCREENSHOTS_DIR="${MACOS_SCREENSHOTS_LOCATION:-$HOME/Pictures/Screenshots}"
mkdir -p "$SCREENSHOTS_DIR"
defaults write com.apple.screencapture location "$SCREENSHOTS_DIR"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
echo "   → Screenshots location: $SCREENSHOTS_DIR"

# ===== Animations =====
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# ===== Restart affected apps =====
killall Finder Dock SystemUIServer 2>/dev/null

echo "✅ macOS configured"
