# Phase 2: Update README

## Overview
- **Priority:** P2
- **Status:** Completed
- **Completion Date:** 2026-03-25
- **Description:** Update README.md to feature the 1-click bootstrap command prominently

## Context
- Depends on Phase 1 (bootstrap.sh must exist)
- Current README has 3-step Quick Start section

## Related Code Files
- **Modify:** `README.md`

## Implementation Steps

1. **Replace Quick Start section** — lead with the curl command:
   ```markdown
   ## Quick Start

   ```bash
   curl -fsSL https://raw.githubusercontent.com/tranxuanliem/dotfiles/main/bootstrap.sh | bash
   ```

   This single command will:
   - Install Xcode CLI tools (if needed)
   - Clone this repo to ~/dotfiles
   - Install everything with sensible defaults

   ### Options

   ```bash
   # Interactive setup (choose your preferences)
   curl -fsSL ... | bash -s -- --interactive

   # Custom install directory
   curl -fsSL ... | bash -s -- --dir ~/.dotfiles
   ```

   ### Manual install
   ```bash
   git clone https://github.com/tranxuanliem/dotfiles.git ~/dotfiles
   cd ~/dotfiles && ./setup.sh && ./install.sh
   ```
   ```

2. **Add bootstrap.sh to Structure section** — add entry under root files

3. **Keep rest of README unchanged**

## Todo List
- [x] Rewrite Quick Start with curl command as primary
- [x] Add Options subsection (--interactive, --dir)
- [x] Keep manual install as fallback
- [x] Add bootstrap.sh to Structure section

## Success Criteria
- curl command is the first thing users see in Quick Start
- Manual 3-step flow preserved as alternative
- All flags documented
