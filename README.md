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
├── starship/       # Prompt config
├── cursor/         # VS Code/Cursor settings & extensions
├── macos/          # macOS system defaults
├── ddev/           # DDEV global config
├── mise/           # Node.js version manager
├── raycast/        # Raycast settings (manual export)
├── warp/           # Warp terminal keybindings
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
- Cursor (editor)
- Warp (terminal)
- Raycast (launcher)
- JetBrains Mono Nerd Font

### DDEV
- DDEV for local PHP development

## Customization

Each folder contains its own `install.sh` that can be run independently:

```bash
# Only update git config
~/dotfiles/git/install.sh

# Only apply macOS settings
~/dotfiles/macos/install.sh
```

## Useful Aliases

| Alias | Command |
|-------|---------|
| `gs` | `git status -sb` |
| `gac "msg"` | `git add -A && git commit -m` |
| `dds` | `ddev start` |
| `c.` | `cursor .` |
| `backup` | Run backup script |

## Notes

- SSH private keys are **not** tracked - only `~/.ssh/config`
- Raycast settings must be exported manually via app
- After install, restart terminal for changes to take effect

## License

MIT
