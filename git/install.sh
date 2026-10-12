#!/bin/bash
set -e

echo "⚙️ Setting up Git..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ ! -f "$DOTFILES_DIR/config.local" ] || source "$DOTFILES_DIR/config.local"
source "$DOTFILES_DIR/lib/config.sh"
if [ -z "${GIT_USER_NAME:-}" ] || [ -z "${GIT_USER_EMAIL:-}" ] ||
   [ "$GIT_USER_NAME" = 'Your Name' ] || [ "$GIT_USER_EMAIL" = 'your@email.com' ]; then
    echo "❌ Set your Git identity in config.local before installing Git configuration."
    exit 1
fi
case "${DEFAULT_EDITOR:-cursor}" in
    vim|nvim|nano) EDITOR_CMD="$DEFAULT_EDITOR" ;;
    *) EDITOR_CMD="${DEFAULT_EDITOR:-cursor} --wait" ;;
esac

# Edit a copy, preserving includeIf/work profiles and unrelated local settings.
# GIT_CONFIG_GLOBAL is also useful for testing without touching the user's config.
git_config_file="${GIT_CONFIG_GLOBAL:-$HOME/.gitconfig}"
temp_config=$(mktemp)
trap 'rm -f "$temp_config"' EXIT
if [ -f "$git_config_file" ]; then cp "$git_config_file" "$temp_config"; fi
set_config() { git config --file "$temp_config" --replace-all "$1" "$2"; }
set_config user.name "$GIT_USER_NAME"
set_config user.email "$GIT_USER_EMAIL"
set_config init.defaultBranch main
set_config core.editor "$EDITOR_CMD"
set_config core.autocrlf input
gitignore_file="${DOTFILES_GITIGNORE_FILE:-$HOME/.gitignore_global}"
set_config core.excludesfile "$gitignore_file"
set_config pull.rebase true
set_config push.autoSetupRemote true
set_config fetch.prune true
set_config diff.algorithm histogram
set_config merge.conflictstyle diff3
set_config alias.co checkout
set_config alias.br branch
set_config alias.ci commit
set_config alias.st 'status -sb'
set_config alias.lg 'log --oneline --graph -15'
set_config alias.undo 'reset HEAD~1 --mixed'
set_config alias.amend 'commit --amend --no-edit'
set_config alias.last 'log -1 HEAD'
set_config color.ui auto
copy_config "$temp_config" "$git_config_file"
link_config "$DOTFILES_DIR/git/.gitignore_global" "$gitignore_file"
echo "✅ Git configured; existing conditional profiles retained."
