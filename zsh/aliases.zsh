# ===== General =====
alias ll="ls -la"
alias la="ls -A"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias reload="source ~/.zshrc"

# ===== Git =====
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gac="git add -A && git commit -m"
alias gp="git push"
alias gl="git pull --prune"
alias gco="git checkout"
alias gcb="git copy-branch-name"
alias gb="git branch"
alias gd="git diff --color"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# ===== DDEV =====
alias dd="ddev"
alias dds="ddev start"
alias ddst="ddev stop"
alias ddr="ddev restart"
alias ddssh="ddev ssh"
alias ddl="ddev launch"
alias ddc="ddev craft"
alias ddco="ddev composer"
alias ddlogs="ddev logs -f"
alias dddb="ddev import-db --src"
alias ddsnap="ddev snapshot"
alias ddpow="ddev poweroff"

# ===== Yarn/NPM =====
alias y="yarn"
alias yi="yarn install"
alias ya="yarn add"
alias yad="yarn add -D"
alias yd="yarn dev"
alias yb="yarn build"
alias yw="yarn watch"

# ===== Editor =====
alias code="cursor"
alias c.="cursor ."

# ===== Misc =====
alias ip="curl -s ipinfo.io | jq"
alias localip="ipconfig getifaddr en0"
alias ports="lsof -i -P -n | grep LISTEN"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# ===== Dotfiles =====
alias backup="~/dotfiles/backup.sh"
