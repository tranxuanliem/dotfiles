# macOS Terminal.app - One Dark Pro Night Flat Theme

Terminal theme matching Cursor/VS Code "One Dark Pro Night Flat" color scheme.

## Quick Install

```bash
./install.sh
```

Or double-click `OneDarkProNightFlat.terminal` to import.

## Manual Installation

1. Open Terminal.app
2. Go to **Terminal > Settings > Profiles**
3. Click the gear icon (⚙️) at bottom
4. Select **Import...**
5. Choose `OneDarkProNightFlat.terminal`
6. Go to **General** tab
7. Set "One Dark Pro Night Flat" as default

## Color Palette

| Color | Normal | Bright |
|-------|--------|--------|
| Black | `#3f4451` | `#4f5666` |
| Red | `#e05561` | `#ff616e` |
| Green | `#8cc265` | `#a5e075` |
| Yellow | `#d18f52` | `#f0a45d` |
| Blue | `#4aa5f0` | `#4dc4ff` |
| Magenta | `#c162de` | `#de73ff` |
| Cyan | `#42b3c2` | `#4cd1e0` |
| White | `#d7dae0` | `#e6e6e6` |

**Background:** `#16191d`
**Foreground:** `#abb2bf`
**Cursor:** `#528bff`
**Selection:** `#677696`

## Regenerate Theme

To regenerate with updated colors:

```bash
swift generate-theme.swift
```

Requires macOS with Swift (pre-installed on macOS).

## Files

- `OneDarkProNightFlat.terminal` - Ready-to-use theme file
- `generate-theme.swift` - Swift script to generate theme
- `generate-theme.py` - Python alternative (requires PyObjC)
- `install.sh` - Installation helper script
