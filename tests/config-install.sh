#!/bin/bash
# Run without modifying the user's home, app state, or package installations.
set -eu
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/config.sh"
test_root=$(mktemp -d)
trap 'rm -rf "$test_root"' EXIT
mkdir -p "$test_root/source files" "$test_root/target files"
source_file="$test_root/source files/config"
target_file="$test_root/target files/config"
printf 'shared config\n' > "$source_file"
printf 'existing personal config\n' > "$target_file"
link_config "$source_file" "$target_file"
[ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]
backups=("${target_file}.backup."*)
[ "${#backups[@]}" -eq 1 ]
[ "$(cat "${backups[0]}")" = 'existing personal config' ]
link_config "$source_file" "$target_file"
backups_after=("${target_file}.backup."*)
[ "${#backups_after[@]}" -eq 1 ]

# A dangling symlink is still valuable state and must be backed up.
broken="$test_root/target files/broken"
ln -s "$test_root/missing" "$broken"
link_config "$source_file" "$broken"
broken_backups=("${broken}.backup."*)
[ -L "${broken_backups[0]}" ]
[ "$(readlink "${broken_backups[0]}")" = "$test_root/missing" ]

# Refuse a real directory and a missing source without destroying either target.
mkdir "$test_root/target files/directory"
if link_config "$source_file" "$test_root/target files/directory"; then exit 1; fi
[ -d "$test_root/target files/directory" ]
if link_config "$test_root/missing" "$target_file"; then exit 1; fi
[ "$(cat "$target_file")" = 'shared config' ]

# Atomic copies preserve the prior content and do not duplicate backups on rerun.
copy_target="$test_root/target files/copy"
printf 'original copy\n' > "$copy_target"
copy_config "$source_file" "$copy_target"
copy_config "$source_file" "$copy_target"
copy_backups=("${copy_target}.backup."*)
[ "${#copy_backups[@]}" -eq 1 ]
[ "$(cat "${copy_backups[0]}")" = 'original copy' ]

# Git setup retains conditional work identity and unrelated preferences.
mkdir -p "$test_root/git-fixture/git" "$test_root/git-fixture/lib"
cp "$DOTFILES_DIR/git/install.sh" "$DOTFILES_DIR/git/.gitignore_global" "$test_root/git-fixture/git/"
cp "$DOTFILES_DIR/lib/config.sh" "$test_root/git-fixture/lib/"
cat > "$test_root/git-fixture/config.local" <<'CONFIG'
GIT_USER_NAME='Test User'
GIT_USER_EMAIL='test@example.invalid'
DEFAULT_EDITOR=vim
CONFIG
cat > "$test_root/git-config" <<'CONFIG'
[includeIf "gitdir:~/work/"]
    path = ~/.gitconfig-work
[credential]
    helper = osxkeychain
CONFIG
GIT_CONFIG_GLOBAL="$test_root/git-config" DOTFILES_GITIGNORE_FILE="$test_root/gitignore" bash "$test_root/git-fixture/git/install.sh"
GIT_CONFIG_GLOBAL="$test_root/git-config" DOTFILES_GITIGNORE_FILE="$test_root/gitignore" bash "$test_root/git-fixture/git/install.sh"
[ "$(git config --file "$test_root/git-config" --get 'includeIf.gitdir:~/work/.path')" = '~/.gitconfig-work' ]
[ "$(git config --file "$test_root/git-config" --get credential.helper)" = osxkeychain ]
[ "$(git config --file "$test_root/git-config" --get core.editor)" = vim ]
git_backups=("$test_root/git-config.backup."*)
[ "${#git_backups[@]}" -eq 1 ]

# Bootstrap must stop before running installers if Git cannot update safely.
mkdir -p "$test_root/mock-bin" "$test_root/bootstrap-repo"
printf '#!/bin/sh\nexit 0\n' > "$test_root/mock-bin/xcode-select"
chmod +x "$test_root/mock-bin/xcode-select"
git -C "$test_root/bootstrap-repo" init -q
git -C "$test_root/bootstrap-repo" -c user.name=Test -c user.email=test@example.invalid commit -qm initial --allow-empty
git -C "$test_root/bootstrap-repo" remote add origin "$test_root/missing-remote"
printf 'local edit\n' > "$test_root/bootstrap-repo/local-file"
if PATH="$test_root/mock-bin:$PATH" bash "$DOTFILES_DIR/bootstrap.sh" --dir "$test_root/bootstrap-repo" > "$test_root/dirty.log" 2>&1; then exit 1; fi
grep -q 'local changes or conflicts' "$test_root/dirty.log"
git -C "$test_root/bootstrap-repo" add local-file
git -C "$test_root/bootstrap-repo" -c user.name=Test -c user.email=test@example.invalid commit -qm local
if PATH="$test_root/mock-bin:$PATH" bash "$DOTFILES_DIR/bootstrap.sh" --dir "$test_root/bootstrap-repo" > "$test_root/offline.log" 2>&1; then exit 1; fi
grep -q 'Update failed' "$test_root/offline.log"

# Wizard inputs must remain literal when config.local is sourced.
mkdir "$test_root/wizard"
cp "$DOTFILES_DIR/setup.sh" "$test_root/wizard/"
python3 - "$test_root/wizard" <<'PY'
import pathlib,subprocess,sys
p=pathlib.Path(sys.argv[1]); marker=p/'must-not-execute'
name='Name " quoted $(touch '+str(marker)+') `false`'
answers=[name,"test@example.invalid","vim","24"]+['']*11
subprocess.run(['bash',str(p/'setup.sh')],input='\n'.join(answers)+'\n',text=True,stdout=subprocess.DEVNULL,check=True)
value=subprocess.check_output(['bash','-c','source "$1"; printf "%s" "$GIT_USER_NAME"','bash',str(p/'config.local')],text=True)
assert value==name and not marker.exists()
assert p.joinpath('config.local').stat().st_mode & 0o077 == 0
PY

# Configuration is syntactically valid before it reaches a user's computer.
while IFS= read -r script; do bash -n "$script"; done < <(find "$DOTFILES_DIR" -name '*.sh' -not -path '*/.git/*')
zsh -n "$DOTFILES_DIR/zsh/.zshrc"
echo 'PASS: backups, repeat installation, dangling symlinks, directory protection, Git profiles, bootstrap failures, wizard quoting and shell syntax.'
