# T3 Code appearance

`one-dark-pro-night-flat.json` maps the dotfiles
[Zed palette](../zed/themes/one-dark-pro-night-flat.json) to T3 Code's supported
color roles. It matches the canvas (`#16191d`), text (`#abb2bf`), panels,
borders, blue accent, and terminal background/foreground/cursor. Muted labels
use `#7f8796` to stay legible in the settings and chat interface.

Verified by importing in T3 Code (Alpha) 0.0.45.

`appearance-backup.json` records the appearance settings verified in the app
on 2026-10-12. It is a portable settings checklist, not a native application
database backup or an importable theme. Together with the theme JSON it
preserves the configured look without accounts, conversations, projects,
credentials, or machine-specific application storage.

## Apply

1. Open Settings → Appearance → Add theme.
2. Choose `one-dark-pro-night-flat.json`, or paste its contents into Theme JSON.
3. Click Add theme, then select dark mode.
4. Set Interface font and Monospace font to `JetBrainsMono Nerd Font Mono`.
5. Set interface and code font sizes to 17 px, matching the Zed profile.
6. Restore the remaining Appearance controls from `appearance-backup.json`
   (contrast, glass opacity, diff colors, chat width, motion, and word wrap).

The import stores a copy in T3 Code. Re-import after changing this file;
this is not a live symlink or automatic synchronization.

T3 Code 0.0.45's theme format exposes 58 color roles. It does not expose
individual syntax token colors or the full ANSI terminal palette, so those
remain controlled by T3 Code. Font settings are separate from theme JSON.

Format reference:
[T3 Code 0.0.45 theme parser](https://github.com/pingdotgg/t3code/blob/v0.0.45/apps/web/src/themePalette.ts).
