#!/bin/bash
# Shared file installation: preserve existing files and skip unchanged symlinks.
link_config() {
    local source_file="$1" target_file="$2" backup_file
    if [ ! -f "$source_file" ]; then
        echo "Missing configuration: $source_file" >&2
        return 1
    fi
    if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
        return 0
    fi
    if [ -d "$target_file" ]; then
        echo "Refusing to replace a directory: $target_file" >&2
        return 1
    fi
    mkdir -p "$(dirname "$target_file")"
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        backup_file=$(mktemp "${target_file}.backup.XXXXXX")
        cp -pP "$target_file" "$backup_file"
        echo "   Backup: $backup_file"
    fi
    ln -sfn "$source_file" "$target_file"
}

copy_config() {
    local source_file="$1" target_file="$2" backup_file temp_file
    if [ ! -f "$source_file" ]; then
        echo "Missing configuration: $source_file" >&2
        return 1
    fi
    if cmp -s "$source_file" "$target_file"; then return 0; fi
    if [ -d "$target_file" ]; then
        echo "Refusing to replace a directory: $target_file" >&2
        return 1
    fi
    mkdir -p "$(dirname "$target_file")"
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        backup_file=$(mktemp "${target_file}.backup.XXXXXX")
        cp -pP "$target_file" "$backup_file"
        echo "   Backup: $backup_file"
    fi
    temp_file=$(mktemp "$(dirname "$target_file")/.dotfiles.XXXXXX")
    cp "$source_file" "$temp_file"
    mv -f "$temp_file" "$target_file"
}
