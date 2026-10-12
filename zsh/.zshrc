# ===== Homebrew =====
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ===== Environment =====
export DOTFILES="${${(%):-%N}:A:h:h}"
# Keep private setup values out of shared configuration.
if [ -f "$DOTFILES/config.local" ]; then
    DEFAULT_EDITOR="$(bash -c 'source "$1"; printf "%s" "${DEFAULT_EDITOR:-cursor}"' bash "$DOTFILES/config.local")"
fi
case "${DEFAULT_EDITOR:-cursor}" in
    vim|nvim|nano) export EDITOR="${DEFAULT_EDITOR}" ;;
    *) export EDITOR="${DEFAULT_EDITOR:-cursor} --wait" ;;
esac
export LANG="en_US.UTF-8"
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

# Optional tools and machine-specific overrides (never committed).
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# ===== Starship =====
command -v starship &>/dev/null && eval "$(starship init zsh)"

# ===== Syntax highlighting (always last) =====
[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
