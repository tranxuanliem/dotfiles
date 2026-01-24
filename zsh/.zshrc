# bun completions
[ -s "/Users/liem.tran/.bun/_bun" ] && source "/Users/liem.tran/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/liem.tran/.lmstudio/bin"

# Added by Antigravity
export PATH="/Users/liem.tran/.antigravity/antigravity/bin:$PATH"

# ===== PATH & Environment =====
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="cursor --wait"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/dotfiles"

# ===== History =====
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ===== Plugins =====
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zoxide
eval "$(zoxide init zsh)"

# Fzf
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
source $(brew --prefix)/opt/fzf/shell/completion.zsh

# ===== Load custom configs =====
for file in $DOTFILES/zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
done

# ===== Starship =====
eval "$(starship init zsh)"

# ===== Syntax highlighting (always last) =====
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
