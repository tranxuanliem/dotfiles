# Phase 1: Create bootstrap.sh

## Overview
- **Priority:** P1
- **Status:** Completed
- **Completion Date:** 2026-03-25
- **Description:** Create bootstrap.sh at repo root — the single entry point for `curl | bash` setup

## Context
- [brainstorm report](../reports/brainstorm-260325-0843-one-click-bootstrap.md)
- Existing: [install.sh](/Users/liem.tran/dotfiles/install.sh), [setup.sh](/Users/liem.tran/dotfiles/setup.sh), [config.example](/Users/liem.tran/dotfiles/config.example)

## Key Insights
- Must work on a **bare macOS** (no git, no brew, no Xcode CLI tools)
- Xcode CLI tools install requires user GUI click — unavoidable, must detect + wait
- Script downloaded via curl, so it runs OUTSIDE the repo initially — must self-bootstrap
- Existing install.sh already handles idempotency per-component

## Requirements

### Functional
- Install Xcode CLI tools if missing (required for git)
- Clone repo to `~/dotfiles` (default) or custom path via `--dir`
- Copy `config.example` → `config.local` with defaults (never overwrite existing)
- Run `install.sh` automatically
- `--interactive` flag triggers `setup.sh` wizard before install
- `--help` flag shows usage

### Non-Functional
- Idempotent (safe to re-run)
- Works on Apple Silicon + Intel
- Works on macOS Sonoma+ (tested target)
- Forkable — only GitHub URL needs changing
- Clean error messages, fail-fast on critical errors

## Related Code Files
- **Create:** `bootstrap.sh` (repo root)
- **Reference:** `install.sh`, `setup.sh`, `config.example`

## Implementation Steps

1. **Script header & flags parsing**
   - `set -e` for fail-fast
   - Parse `--interactive`, `--dir <path>`, `--help`
   - Set defaults: `DOTFILES_DIR="$HOME/dotfiles"`, `INTERACTIVE=false`

2. **Xcode CLI tools check + install**
   ```bash
   if ! xcode-select -p &>/dev/null; then
     xcode-select --install
     # Wait for install to complete
     until xcode-select -p &>/dev/null; do sleep 5; done
   fi
   ```

3. **Clone or update repo**
   ```bash
   if [ -d "$DOTFILES_DIR/.git" ]; then
     echo "Dotfiles already cloned, pulling latest..."
     git -C "$DOTFILES_DIR" pull --ff-only
   else
     git clone https://github.com/tranxuanliem/dotfiles.git "$DOTFILES_DIR"
   fi
   ```

4. **Config handling**
   ```bash
   if [ ! -f "$DOTFILES_DIR/config.local" ]; then
     if [ "$INTERACTIVE" = true ]; then
       bash "$DOTFILES_DIR/setup.sh"
     else
       cp "$DOTFILES_DIR/config.example" "$DOTFILES_DIR/config.local"
       echo "Using default config. Edit ~/dotfiles/config.local to customize."
     fi
   fi
   ```

5. **Run installer**
   ```bash
   bash "$DOTFILES_DIR/install.sh"
   ```

6. **Post-install summary**
   - Print success banner
   - List manual steps (SSH key, Raycast, Warp theme)
   - Mention `config.local` for customization

## Todo List
- [x] Create bootstrap.sh with flag parsing
- [x] Xcode CLI tools detection + install + wait loop
- [x] Git clone / pull logic
- [x] Config.local handling (default copy vs interactive wizard)
- [x] Run install.sh
- [x] Post-install output
- [x] Make executable (`chmod +x`)
- [x] Test: fresh run (no repo), re-run (repo exists), --interactive, --dir, --help

## Success Criteria
- `curl -fsSL .../bootstrap.sh | bash` works on fresh Mac
- `curl -fsSL .../bootstrap.sh | bash -s -- --interactive` triggers wizard
- Re-running skips clone, preserves config.local
- `--dir /custom/path` clones to custom location
- Clean exit codes (0 success, 1 error)

## Risk Assessment
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Xcode CLI install hang | Low | High | Timeout after 30min, print instructions |
| git clone fails (network) | Low | High | Clear error message, exit 1 |
| config.example missing/changed | Very Low | Medium | Check file exists before copy |

## Security Considerations
- Script is public on GitHub — no secrets embedded
- config.local is git-ignored (contains email)
- SSH key generation happens in install.sh (already handled)
