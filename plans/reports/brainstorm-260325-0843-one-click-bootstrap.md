# Brainstorm: 1-Click MacBook Setup

**Date:** 2026-03-25
**Status:** Agreed — Approach A selected

## Problem
Current dotfiles setup requires 3 commands (clone → setup wizard → install). Goal: single `curl | bash` on fresh Mac, public/forkable, sensible defaults + optional wizard.

## Evaluated Approaches

### A. Bootstrap Script (SELECTED)
`curl -fsSL .../bootstrap.sh | bash` — installs Xcode CLI tools, clones repo, copies config.example as defaults, runs install.sh. `--interactive` flag triggers wizard.
- **Pros:** Industry standard, no new deps, existing scripts untouched, forkable
- **Cons:** curl|bash trust (mitigated: public repo), Xcode CLI click unavoidable

### B. Bootstrap + Remote Config
Adds `--config <url>` to fetch config.local from gist/URL.
- **Rejected:** Over-engineered for public/forkable goal, security concern with public gist

### C. Makefile Wrapper
`git clone && make` — doesn't solve fresh Mac (no git) problem. Still 2 commands.
- **Rejected:** Doesn't meet 1-click requirement

### D. .command File (Finder double-click)
Gatekeeper blocks unsigned scripts, overkill for dev audience.
- **Rejected:** Poor UX due to macOS security warnings

## Agreed Solution: Approach A

### Key Behaviors
| Scenario | Behavior |
|----------|----------|
| Fresh Mac, no args | Xcode CLI → clone → defaults from config.example → install.sh |
| `--interactive` flag | Runs setup.sh wizard before install |
| Already cloned | Skip clone, run install |
| Existing config.local | Respect it, don't overwrite |
| Custom path | `--dir` flag |

### Design Principles
- Idempotent (safe to re-run)
- Never overwrite existing config.local
- Sensible defaults from config.example

### Risks
- Xcode CLI tools manual click (unavoidable)
- Homebrew install duration (inherent bottleneck)
- curl|bash trust (public repo, inspectable)

## Next Steps
Create implementation plan for bootstrap.sh + README update.
