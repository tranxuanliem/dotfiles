#!/bin/bash
set -e

echo "⚙️ Setting up T3 Code..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
[ ! -f "$DOTFILES_DIR/config.local" ] || source "$DOTFILES_DIR/config.local"
if [ "${INSTALL_T3CODE:-true}" = "false" ]; then
    echo "   Skipped (disabled in config)"
    exit 0
fi

# Match the CLI to the installed desktop release. Never launch a second server.
if ! command -v t3 >/dev/null 2>&1; then
    if [ "$(uname -s)" = Darwin ] && [ "$(uname -m)" != arm64 ]; then
        echo "   Intel Mac: use the desktop's Settings → General → t3 command → Install."
    else
        installer=$(mktemp)
        trap 'rm -f "$installer"' EXIT
        curl --proto '=https' --tlsv1.2 -fsSL https://t3.codes/install.sh -o "$installer"
        desktop_plist="/Applications/T3 Code (Alpha).app/Contents/Info.plist"
        desktop_version=""
        if [ -f "$desktop_plist" ]; then
            desktop_version=$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' "$desktop_plist")
        fi
        if [ -n "$desktop_version" ]; then
            T3CODE_VERSION="$desktop_version" sh "$installer"
        else
            sh "$installer"
        fi
    fi
fi
export PATH="$HOME/.local/bin:$PATH"

# Publish only portable appearance data; accounts, project state and secrets stay local.
state_root="${T3CODE_HOME:-$HOME/.t3}"
theme_dir="$state_root/userdata/themes"
mkdir -p "$theme_dir"
theme_file="$theme_dir/one-dark-pro-night-flat.json"
if ! cmp -s "$DOTFILES_DIR/t3code/one-dark-pro-night-flat.json" "$theme_file"; then
    if [ -e "$theme_file" ] || [ -L "$theme_file" ]; then
        backup_file=$(mktemp "${theme_file}.backup.XXXXXX")
        cp -pP "$theme_file" "$backup_file"
        echo "   Backup: $backup_file"
    fi
    temp_theme=$(mktemp "$theme_dir/.theme.XXXXXX")
    cp "$DOTFILES_DIR/t3code/one-dark-pro-night-flat.json" "$temp_theme"
    mv -f "$temp_theme" "$theme_file"
fi

if command -v t3 >/dev/null 2>&1; then
    t3 theme set --base-dir "$state_root" one-dark-pro-night-flat
    t3 theme show --base-dir "$state_root"
else
    echo "   Theme published. Install the t3 command, then run:"
    echo "   t3 theme set --base-dir \"$state_root\" one-dark-pro-night-flat"
fi
echo "✅ T3 Code theme configured. Restore font preferences from t3code/appearance-backup.json in Settings → Appearance."
