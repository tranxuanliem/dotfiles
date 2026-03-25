---
title: "1-Click MacBook Bootstrap"
description: "Add bootstrap.sh for single curl|bash setup on fresh Mac"
status: completed
priority: P2
effort: 2h
branch: main
tags: [infra, feature]
created: 2026-03-25
completed: 2026-03-25
---

# 1-Click MacBook Bootstrap

## Overview

Add `bootstrap.sh` enabling `curl -fsSL .../bootstrap.sh | bash` on a fresh Mac. Installs Xcode CLI tools, clones repo, applies default config, runs install.sh. Interactive wizard available via `--interactive` flag.

## Context

- Brainstorm: [brainstorm report](../reports/brainstorm-260325-0843-one-click-bootstrap.md)
- Current: 3-command flow (clone → setup.sh → install.sh)
- Target: 1-command flow via curl pipe

## Phases

| # | Phase | Status | Effort | Link |
|---|-------|--------|--------|------|
| 1 | Create bootstrap.sh | Completed | 1.5h | [phase-01](./phase-01-create-bootstrap-script.md) |
| 2 | Update README | Completed | 0.5h | [phase-02-update-readme.md](./phase-02-update-readme.md) |

## Dependencies

- No external dependencies
- Phase 2 depends on Phase 1 (needs to reference bootstrap.sh behavior)

## Completion Summary

✅ **All phases completed on 2026-03-25**

### Phase 1: bootstrap.sh
- Created fully functional bootstrap script with flag parsing
- Implemented Xcode CLI tools detection + installation with wait loop
- Added git clone/pull logic with idempotency
- Implemented config.local handling (default copy + interactive wizard support)
- Integrated install.sh execution
- Added post-install summary output
- Script tested and ready for production

### Phase 2: README.md
- Updated Quick Start section with curl command as primary entry point
- Added Options subsection documenting --interactive and --dir flags
- Preserved manual 3-step flow as fallback
- Added bootstrap.sh to Structure section

### Code Review
- Passed code review (8.5/10)
- No critical issues remaining
- Ready to ship to production
