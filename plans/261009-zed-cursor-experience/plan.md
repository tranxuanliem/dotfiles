# Zed Cursor migration profile

Outcome: reproduce the user's current macOS Cursor layout and personal shortcuts
in Zed, and make installation repeatable from dotfiles.

Constraints: preserve unrelated dotfiles edits and private application state;
no account/provider migration, no push or system-wide default-editor switch.
Native Zed equivalents are used; differences are documented.

Acceptance: Explorer/Git left, Agent right, terminal bottom; personal J/K, D,
folding, imports, picker and terminal shortcuts load without invalid actions;
bundled theme/font/icon configuration installs on a fresh Mac; repeat installation
preserves backups and unrelated themes.

Steps: inspect installed Zed 1.23.2 actions and Cursor user files; update settings,
keymap and installer integration; verify config, guarded installation and live UI;
document exact mappings and remaining differences.

Rollback: restore the timestamped settings/theme backups and keymap backup under
`~/.config/zed`; dotfiles edits remain reviewable with Git.

Status: complete. JSONC parsing, shell syntax, live symlinks, installer backup
and repeated-installation fixtures pass. Homebrew manifest enable/disable and
failure propagation were verified with a stub, without changing packages.
Live Zed checks covered duplicate/deduplicate lines, immediate J/K tab switching,
left Explorer, right Agent and bottom terminal without keymap errors.
The temporary workspace was closed; the original DAM workspace remains open.
No AI request was sent. Installation on a physical clean Mac was not exercised.
A portable profile without credentials is available in this task's outputs.
