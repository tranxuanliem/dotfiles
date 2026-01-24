cl# Dotfiles

Opinionated macOS dotfiles for web developers. Includes configurations for terminal, editors, and development tools with a consistent **One Dark Pro** theme.

## Features

- **Interactive setup wizard** - Configure your name, email, and preferences
- **Modular installation** - Install only what you need
- **One Dark Pro theme** - Consistent dark theme across all apps
- **Developer-focused** - Optimized for web development (JS/TS, PHP, Python)

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/tranxuanliem/dotfiles.git ~/dotfiles

# 2. Run setup wizard (creates your personal config)
cd ~/dotfiles && chmod +x setup.sh install.sh && ./setup.sh

# 3. Install everything
./install.sh
```

## What's Included

### Terminal & Shell
| Tool | Description |
|------|-------------|
| **Zsh** | Shell with aliases, functions, and plugins |
| **Starship** | Beautiful two-line prompt with git status |
| **Ghostty** | GPU-accelerated terminal |
| **Warp** | AI-powered terminal |
| **Terminal.app** | macOS default terminal (themed) |

### Editors
| Tool | Description |
|------|-------------|
| **Cursor** | AI-powered VS Code fork |
| **Zed** | Fast, collaborative editor |
| **OpenCode** | AI coding assistant (CLI) |

### Development
| Tool | Description |
|------|-------------|
| **mise** | Runtime version manager (Node.js, Python, etc.) |
| **DDEV** | Local PHP development (optional) |
| **OrbStack** | Docker alternative for macOS (optional) |
| **mkcert** | Local HTTPS certificates |

### Utilities
| Tool | Description |
|------|-------------|
| **fzf** | Fuzzy finder |
| **zoxide** | Smart cd command |
| **gh** | GitHub CLI |
| **Raycast** | Spotlight replacement |

## Configuration

After running `setup.sh`, a `config.local` file is created with your preferences:

```bash
# Example config.local
GIT_USER_NAME="Your Name"
GIT_USER_EMAIL="your@email.com"
DEFAULT_EDITOR="cursor"
NODE_VERSION="20"
INSTALL_DDEV="true"
INSTALL_ORBSTACK="true"
MACOS_DOCK_AUTOHIDE="true"
# ... more options
```

See `config.example` for all available options.

## Structure

```
~/dotfiles/
├── setup.sh            # First-time setup wizard
├── install.sh          # Main installer
├── backup.sh           # Backup current settings
├── config.example      # Example configuration
├── config.local        # Your personal config (git-ignored)
│
├── zsh/                # Shell config
│   ├── .zshrc
│   ├── aliases.zsh
│   └── functions.zsh
│
├── git/                # Git config
├── ssh/                # SSH config
├── starship/           # Prompt config
├── cursor/             # Cursor/VS Code settings
├── ghostty/            # Ghostty terminal config
├── terminal/           # macOS Terminal.app theme
├── zed/                # Zed editor config
├── warp/               # Warp terminal theme
├── opencode/           # OpenCode AI assistant config
├── homebrew/           # Brewfile
├── macos/              # macOS system preferences
├── mise/               # Runtime manager
└── ddev/               # DDEV config
```

## Customization

### Install specific components

```bash
# Only setup git
~/dotfiles/git/install.sh

# Only apply macOS settings
~/dotfiles/macos/install.sh

# Only setup Cursor
~/dotfiles/cursor/install.sh
```

### macOS Settings

The setup wizard asks about common preferences:
- Show hidden files in Finder
- Auto-hide Dock
- Fast key repeat (for vim users)
- Tap to click on trackpad
- Screenshots location

## Useful Aliases

| Alias | Command |
|-------|---------|
| `gs` | `git status -sb` |
| `gac "msg"` | `git add -A && git commit -m` |
| `gl` | `git pull` |
| `gp` | `git push` |
| `dds` | `ddev start` |
| `c.` | `cursor .` |
| `..` | `cd ..` |
| `backup` | Run backup script |

## Keybindings

### Cursor / Zed
| Key | Action |
|-----|--------|
| `Cmd+J/K` | Navigate tabs / suggestions |
| `Cmd+L` | Toggle AI panel (Zed) |
| `Cmd+D` | Duplicate line |
| `Alt+Up/Down` | Move line |
| `Cmd+1/2/3` | Fold levels |

### Ghostty
| Key | Action |
|-----|--------|
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+N` | New window |
| `Ctrl++/-` | Font size |

## Backup & Sync

```bash
# Backup current settings to dotfiles
~/dotfiles/backup.sh

# This will:
# - Export Cursor settings & extensions
# - Export Ghostty, Zed, Starship configs
# - Export Warp themes
# - Export Brewfile
# - Commit and push changes
```

## Font

All configurations use **JetBrains Mono Nerd Font**. It's automatically installed via Homebrew.

## Theme

**One Dark Pro Night Flat** is configured across:
- Cursor / VS Code
- Ghostty terminal
- Warp terminal
- macOS Terminal.app
- Zed editor
- OpenCode CLI

## Uninstall

To remove symlinks and restore defaults:

```bash
# Remove symlinks
rm ~/.zshrc ~/.gitconfig ~/.gitignore_global
rm ~/.config/starship.toml
rm -rf ~/.config/ghostty ~/.config/zed ~/.config/opencode
```

## Requirements

- macOS (tested on Sonoma 14.x)
- Apple Silicon or Intel Mac
- Internet connection (for Homebrew)

## Credits

Inspired by:
- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
- [Zach Holman's dotfiles](https://github.com/holman/dotfiles)

## License

MIT
