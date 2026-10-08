# Zed with personal Cursor controls

This macOS profile mirrors the current personal Cursor settings, rather than
only Cursor's factory shortcuts. It uses `base_keymap: Cursor` for standard
navigation, search, selection and AI behavior, with personal overrides in
`keymap.json`. Verified against Zed 1.23.2 actions.

Homebrew installs the current official stable cask, not a pinned 1.23.2 build.
After a major upgrade, check for keymap warnings and try Cmd+J/K, Cmd+D,
Cmd+1/2/3 and the terminal toggle before using it for work. New Zed versions
may rename actions; this profile should then be updated against their defaults.

## Fresh Mac

After cloning this repository and installing Homebrew:

```bash
brew install --cask zed font-jetbrains-mono-nerd-font
# If config.local exists, set INSTALL_ZED="true" in it first.
bash ~/dotfiles/zed/install.sh
```

Alternatively, the full dotfiles installer installs Zed when `INSTALL_ZED=true`.
The setup wizard and `config.example` enable Zed by default. Open Zed after
installation; `auto_install_extensions` requests Material Icon Theme and the
existing language extensions. Extensions require Internet access. Sign in to
Zed or configure your AI provider separately; credentials and account state are
not stored here. Existing model and edit-prediction preferences are retained.

The installer links settings, keymap and bundled themes. Existing files are
backed up before replacement. Repeated installation preserves those backups;
unrelated themes remain untouched. It respects `XDG_CONFIG_HOME`, falling back
to `~/.config/zed`. The root backup script copies local configuration and themes,
skipping files already linked to dotfiles.

## Layout and editing

Explorer, Outline and Git dock left; Agent docks right; terminal docks below.
Preview tabs remain enabled for Explorer clicks and disabled for Quick Open.
The editor wraps at window width, has a 120-column guide, sticky scopes, trailing
whitespace markers, and Command-click multi-cursors. Inlay hints are hidden
until Control+Option is held. Formatting on save, trimming whitespace and a
final newline remain enabled; JS/TS/CSS/HTML/JSON use Prettier. Auto-save is
off, matching Cursor's default; indentation is 4 spaces. Prettier fallback
options match Cursor (single quotes, tab width 4, print width 120); project
Prettier installations/configuration take precedence.

One Dark Pro Night Flat uses Cursor's UI palette. Editor font is JetBrainsMono
Nerd Font Mono, 14px, weight 500, line height 1.6; UI font is the macOS system
font. Theme source: installed Cursor `zhuangtongfa.material-theme` 3.20.3.
Tree-sitter captures differ from TextMate scopes, so syntax is matched by token
family, not every language-specific rule.

## Shortcuts

| Keys | Behavior |
|---|---|
| Cmd+P / Cmd+Shift+P | Quick Open / command palette |
| Cmd+J / Cmd+K | Previous / next editor tab |
| Cmd+Ctrl+J / Cmd+Ctrl+K | Move tab left / right |
| Cmd+J / Cmd+K in picker or completion menu | Next / previous suggestion |
| Cmd+D in editor | Duplicate line down |
| Cmd+Shift+D in editor | Remove duplicate selected lines, case-sensitive |
| Option+Up / Down | Move lines |
| Cmd+1 / Cmd+2 / Cmd+3 | Fold level 1 / fold level 2 / unfold all |
| Cmd+Shift+O | Organize imports |
| Cmd+Option+O | Symbol in current file (outline) |
| Cmd+Option+D | Select next occurrence (Cmd+D is personal duplicate-line binding) |
| Cmd+Shift+K / Cmd+/ | Delete line / toggle comment |
| Option+Shift+F / F2 / F12 | Format / rename / definition |
| Cmd+B / Cmd+Shift+E | Toggle left sidebar / focus Explorer |
| Ctrl+Shift+G | Focus Git |
| Cmd+Option+S | Toggle AI sidebar, closest equivalent to Cursor unified sidebar |
| Cmd+L / Cmd+Shift+L in editor | Add selection to Agent and open it |
| Cmd+L in Agent | Hide right sidebar |
| Cmd+Option+K | Inline AI (Cmd+K is reserved for next tab) |
| Ctrl+Enter in editor or terminal | Alternate inline AI from the base keymap |
| Cmd+N / Cmd+R in Agent | New thread |
| Cmd+Shift+H in Agent | Toggle thread history |
| Cmd+backtick | Toggle terminal |
| Ctrl+Shift+backtick | New terminal (base binding uses the shifted `~` character) |
| Cmd+N / Cmd+D / Cmd+W in terminal | New / split / close terminal |
| Cmd+J / Cmd+K in terminal | Previous / next pane |
| Cmd+Shift+M | Zoom current pane or dock; use with terminal focused for panel maximize |
| Cmd+Option+M | Problems/diagnostics (moved because Cmd+Shift+M maximizes) |
| Cmd+W / Cmd+Shift+T | Close / reopen tab |
| Cmd+backslash | Split editor right |
| Cmd+F / Cmd+Shift+F / Cmd+Shift+H | Find / project search / project replace |
| Ctrl+G / Cmd+T | Go to line / workspace symbol |
| Cmd+, / Cmd+Option+, / Cmd+Option+semicolon | Settings UI / settings file / keymap UI |

Cmd+K multi-key chords are explicitly disabled so switching tabs has no chord
wait. Their actions remain available in the command palette or alternate keys.
The personal Cursor disables Option+Shift+Up/Down duplication, so Zed does too.

## Differences

Zed uses native docks, a status bar and a multi-buffer search view; Cursor's
activity bar, unified sidebar and extension UI cannot be reproduced exactly.
Terminal pane cycling can include editor panes. Cmd+Shift+M zooms the focused
pane/dock rather than always targeting the bottom panel. Cursor extensions,
agent workflows, model access and subscriptions do not transfer to Zed.
Cursor's smooth caret animation, precise letter spacing, and formatting on
paste/type are not configured as equivalent Zed features. Formatting on save
and explicit formatting are available. Projects may override user settings.

To restore, remove the managed symlink and put its saved backup back at the
same path. Zed may rewrite config files when using its settings UI; the next
installer run restores the dotfiles links after backing up a replaced file.

References: [Zed keybindings](https://zed.dev/docs/key-bindings),
[local themes](https://zed.dev/docs/themes#local-themes), and
[settings](https://zed.dev/docs/reference/all-settings).
