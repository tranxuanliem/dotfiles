# Dotfiles

Personal dotfiles for macOS development environment.

## Quick Start

### Fresh Machine Setup

```bash
# Clone this repo
git clone git@github.com:tranxuanliem/dotfiles.git ~/dotfiles

# Make scripts executable
chmod +x ~/dotfiles/install.sh ~/dotfiles/backup.sh ~/dotfiles/*/install.sh

# Run installer
cd ~/dotfiles && ./install.sh
```

### Backup Current Settings

```bash
~/dotfiles/backup.sh
```

## Structure

```
~/dotfiles/
├── homebrew/       # Brewfile & packages
├── zsh/            # Shell config, aliases, functions
├── git/            # Git config & global gitignore
├── ssh/            # SSH config (keys not tracked)
├── starship/       # Prompt config (two-line with icons)
├── cursor/         # Cursor settings, keybindings & extensions
├── ghostty/        # Ghostty terminal config (One Dark Pro theme)
├── zed/            # Zed editor settings & keymap
├── warp/           # Warp terminal themes
├── macos/          # macOS system defaults
├── ddev/           # DDEV global config
├── mise/           # Node.js version manager
├── raycast/        # Raycast settings (manual export)
├── bin/            # Custom scripts
├── install.sh      # Main installer
└── backup.sh       # Backup script
```

## What Gets Installed

### CLI Tools
- mise (runtime manager)
- starship (prompt)
- zoxide (smart cd)
- fzf (fuzzy finder)
- zsh-autosuggestions
- zsh-syntax-highlighting
- git, gh, jq
- mkcert, nss (SSL)

### Applications
- OrbStack (Docker)
- Cursor (AI editor)
- Ghostty (GPU terminal)
- Zed (fast editor)
- Warp (AI terminal)
- Raycast (launcher)
- JetBrains Mono Nerd Font

### DDEV
- DDEV for local PHP development

## Theme

All apps use **One Dark Pro Night Flat** color scheme:
- Background: `#16191d`
- Foreground: `#abb2bf`
- Font: JetBrainsMono Nerd Font (14px)

## Customization

Each folder contains its own `install.sh` that can be run independently:

```bash
# Only update git config
~/dotfiles/git/install.sh

# Only apply macOS settings
~/dotfiles/macos/install.sh

# Only update Cursor settings
~/dotfiles/cursor/install.sh
```

## Useful Aliases

| Alias | Command |
|-------|---------|
| `gs` | `git status -sb` |
| `gac "msg"` | `git add -A && git commit -m` |
| `dds` | `ddev start` |
| `c.` | `cursor .` |
| `backup` | Run backup script |

## Keybindings

### Cursor / Zed
- `Cmd+J/K` - Navigate tabs / suggestions
- `Cmd+L` - Toggle AI panel (Zed)
- `Cmd+D` - Duplicate line
- `Alt+Up/Down` - Move line
- `Cmd+1/2/3` - Fold levels

### Terminal (Ghostty)
- `Ctrl+Shift+T` - New tab
- `Ctrl+Shift+N` - New window
- `Ctrl++/-` - Font size

## Notes

- SSH private keys are **not** tracked - only `~/.ssh/config`
- Raycast settings must be exported manually via app
- After install, restart terminal for changes to take effect

## License

MIT
