# ===== Homebrew =====
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ===== Environment =====
export EDITOR="${DEFAULT_EDITOR:-cursor} --wait"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/dotfiles"
export PATH="$HOME/.local/bin:$PATH"

# ===== Bun (if installed) =====
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ===== History =====
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ===== Plugins =====
BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Fzf
[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

# Mise
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# ===== Load custom configs =====
for file in $DOTFILES/zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
done

# ===== Starship =====
command -v starship &>/dev/null && eval "$(starship init zsh)"

# ===== Syntax highlighting (always last) =====
[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
