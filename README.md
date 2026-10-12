# Dotfiles

Opinionated macOS dotfiles for web developers. Includes configurations for terminal, editors, and development tools with a consistent **One Dark Pro** theme.

## Features

- **Interactive setup wizard** - Configure your name, email, and preferences
- **Modular installation** - Install only what you need
- **One Dark Pro theme** - Consistent dark theme across all apps
- **Developer-focused** - Optimized for web development (JS/TS, PHP, Python)

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash
```

This single command will:
- Install Xcode CLI tools (if needed)
- Clone this repo to ~/dotfiles
- Create a private `config.local` for you to review
- Stop so you can set your Git name/email, then run `bash ~/dotfiles/install.sh`

### Options

```bash
# Interactive setup (choose your preferences)
curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash -s -- --interactive

# Custom install directory
curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash -s -- --dir ~/.dotfiles
```

### Manual Install

If you prefer manual control over each step:

```bash
git clone https://github.com/tranxuanliem/dotfiles.git ~/dotfiles
cd ~/dotfiles && chmod +x setup.sh install.sh && ./setup.sh
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
| **T3 Code** | Desktop control surface for AI coding agents |

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
NODE_VERSION="24"
INSTALL_DDEV="true"
INSTALL_ORBSTACK="true"
MACOS_DOCK_AUTOHIDE="true"
# ... more options
```

See `config.example` for all available options.

## Structure

```
~/dotfiles/
├── bootstrap.sh        # One-click setup for fresh Mac (curl | bash)
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
├── t3code/             # T3 Code theme and installer
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

Zed mirrors the personal Cursor shortcuts, including `Cmd+D` to duplicate a
line and `Cmd+1/2/3` to fold level 1, fold level 2, and unfold all. See the
[Zed setup and shortcut guide](zed/README.md) for the full mapping and fresh-Mac setup.

## Setup on another computer

Use `--interactive` to enter that computer's Git identity and select tools.
Private `config.local` stays on each machine. New setups default to Node.js 24
LTS ([release schedule](https://nodejs.org/en/about/previous-releases)); existing
project/runtime choices in `config.local` remain yours. Put machine-specific shell paths
and environment variables in `~/.zshrc.local`; never commit credentials or
application databases. Ghostty uses the repository palette and installed Nerd
Font; T3 Code publishes that palette with its official theme command.

Ghostty, Zed, Zsh, Git, Cursor, Starship and Warp preserve existing files as `*.backup.*` before
replacement. Git retains conditional profiles, and existing SSH host settings
remain on each computer. Zed retains the newer Cursor profile, theme and personal shortcuts.
The shell respects the selected editor and custom dotfiles location. Bootstrap
stops on a dirty checkout or failed pull so it cannot install conflicted files.

For updates, review and commit local changes first, then:

```bash
cd ~/dotfiles
git pull --ff-only
bash ghostty/install.sh
bash t3code/install.sh
```

App upgrades are separate: `brew upgrade --cask ghostty t3-code`, then update
`t3` to match the desktop version if needed. Authenticate agent providers on
each computer; account tokens are not part of dotfiles.

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
- T3 Code ([setup and appearance guide](t3code/README.md))

## Uninstall

To remove symlinks and restore defaults:

```bash
# Remove symlinks
rm ~/.zshrc ~/.gitconfig ~/.gitignore_global
rm ~/.config/starship.toml
rm -rf ~/.config/ghostty ~/.config/zed ~/.config/opencode
```

## Verification

Run `bash tests/config-install.sh` to check shell syntax, recoverable file
replacement, repeat installs, Git profile preservation, bootstrap failure
handling and literal setup input. Tests use temporary directories and do not
install packages or modify home-directory configuration.

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
