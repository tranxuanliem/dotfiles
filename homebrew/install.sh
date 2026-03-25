#!/bin/bash

echo "⚙️ Setting up Homebrew..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load config if available
if [ -f "$DOTFILES_DIR/config.local" ]; then
    source "$DOTFILES_DIR/config.local"
fi

# Detect architecture
if [ "$(uname -m)" = "arm64" ]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\"" >> ~/.zprofile
    eval "$("${BREW_PREFIX}/bin/brew" shellenv)"
fi

# Create dynamic Brewfile based on config
TEMP_BREWFILE=$(mktemp)

# Taps must come before formulae that depend on them
if [ "$INSTALL_DDEV" = "true" ]; then
    echo 'tap "ddev/ddev"' >> "$TEMP_BREWFILE"
fi

cat >> "$TEMP_BREWFILE" << 'EOF'

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
cask "warp"
cask "raycast"
cask "font-jetbrains-mono-nerd-font"
EOF

# Optional: Ghostty
if [ "$INSTALL_GHOSTTY" != "false" ]; then
    echo 'cask "ghostty"' >> "$TEMP_BREWFILE"
fi

# Optional: DDEV
if [ "$INSTALL_DDEV" = "true" ]; then
    echo 'brew "ddev"' >> "$TEMP_BREWFILE"
fi

# Optional: OrbStack
if [ "$INSTALL_ORBSTACK" = "true" ]; then
    echo 'cask "orbstack"' >> "$TEMP_BREWFILE"
fi

# Install from Brewfile
echo "📦 Installing packages..."
brew bundle install --file="$TEMP_BREWFILE" || echo "⚠️  Some packages failed to install. Check output above."

rm "$TEMP_BREWFILE"

echo "✅ Homebrew configured"
