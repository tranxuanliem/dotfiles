# ===== Homebrew =====
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===== Environment =====
export EDITOR="cursor --wait"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/dotfiles"

# ===== History =====
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# ===== Mise =====
eval "$(mise activate zsh)"

# ===== Zoxide =====
eval "$(zoxide init zsh)"

# ===== Plugins =====
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
source $(brew --prefix)/opt/fzf/shell/completion.zsh

# ===== Starship =====
eval "$(starship init zsh)"

# ===== Load custom configs =====
for file in $DOTFILES/zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
done

# ===== Syntax Highlighting (must be last) =====
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
