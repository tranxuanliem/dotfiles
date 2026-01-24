#!/bin/bash

echo "⚙️ Setting up Homebrew..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Create dynamic Brewfile based on config
TEMP_BREWFILE=$(mktemp)

cat > "$TEMP_BREWFILE" << 'EOF'
# Taps
tap "homebrew/bundle"

# CLI Tools (always install)
brew "mise"
brew "starship"
brew "zoxide"
brew "fzf"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "git"
brew "gh"
brew "mkcert"
brew "nss"
brew "jq"

# Applications (always install)
cask "cursor"
cask "ghostty"
cask "warp"
cask "raycast"
cask "font-jetbrains-mono-nerd-font"
EOF

# Optional: DDEV
if [ "$INSTALL_DDEV" = "true" ]; then
    echo 'tap "ddev/ddev"' >> "$TEMP_BREWFILE"
    echo 'brew "ddev"' >> "$TEMP_BREWFILE"
fi

# Optional: OrbStack
if [ "$INSTALL_ORBSTACK" = "true" ]; then
    echo 'cask "orbstack"' >> "$TEMP_BREWFILE"
fi

# Install from Brewfile
echo "📦 Installing packages..."
brew bundle install --file="$TEMP_BREWFILE"

rm "$TEMP_BREWFILE"

echo "✅ Homebrew configured"
