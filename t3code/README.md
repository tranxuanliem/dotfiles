# T3 Code appearance

The One Dark Pro Night Flat palette matches Ghostty, Cursor and Zed in this
repository. The native JSON contains only appearance colors. Accounts,
conversations, projects, credentials and machine-specific application storage
are never copied into dotfiles.

## Install on another Mac

Run the setup wizard and leave `INSTALL_T3CODE=true` and `INSTALL_GHOSTTY=true`.
The full installer installs both stable Homebrew casks and the Nerd Font, then
applies their configuration. To set up only these apps:

```bash
brew install --cask t3-code ghostty font-jetbrains-mono-nerd-font
bash ~/dotfiles/ghostty/install.sh
bash ~/dotfiles/t3code/install.sh
```

If `config.local` disables either app, enable it first. T3 Code's installer
installs its official CLI if missing, matching the installed desktop version
on Apple Silicon. On Intel, use Settings → General → t3 command → Install.
Keep an existing CLI updated to the same release as the desktop app.

The installer publishes the palette in `~/.t3/userdata/themes/` and uses
`t3 theme set one-dark-pro-night-flat`. Connected local clients switch to it;
offline clients apply it when they reconnect. Re-run the installer after
editing the theme. Existing palette files are backed up before replacement,
and updates use an atomic rename. `T3CODE_HOME` selects an alternate data root.
The installer does not start another server or enable remote access.

## Device appearance preferences

`appearance-backup.json` is a portable settings checklist, not a database
backup or an importable theme. In Settings → Appearance use:

- Dark mode and One Dark Pro Night Flat.
- Interface and monospace font: `JetBrainsMono Nerd Font Mono`.
- Interface size: 16 px; code size: 15 px.
- Contrast: 100%; glass opacity: 80%; diff colors: Red & green.
- Chat width: Comfortable; panel animations: 0 ms; word wrap: enabled.

Fonts and layout are device preferences separate from environment theme
colors. Restore them on each computer; server themes only synchronize palettes.
If a client has a custom theme with the same ID, its custom copy wins. Remove
that stale copy or re-import the repository theme in the app.

Verified with T3 Code 0.0.45. Its theme format exposes 58 color roles; syntax
token colors and the full terminal ANSI palette remain controlled by T3 Code.

[Appearance documentation](https://github.com/pingdotgg/t3code/blob/v0.0.45/docs/user/appearance.md)
