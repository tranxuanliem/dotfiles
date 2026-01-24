#!/usr/bin/env python3
"""
Generate macOS Terminal.app theme from One Dark Pro Night Flat color palette.
Matches Cursor/VS Code theme colors.
"""

import plistlib
from pathlib import Path

try:
    from AppKit import NSColor, NSKeyedArchiver
    HAS_APPKIT = True
except ImportError:
    HAS_APPKIT = False


# One Dark Pro Night Flat color palette (matching Cursor theme)
COLORS = {
    "background": "#16191d",
    "foreground": "#abb2bf",
    "cursor": "#528bff",
    "selection": "#677696",
    "bold": "#e6e6e6",
    # Normal ANSI colors
    "black": "#3f4451",
    "red": "#e05561",
    "green": "#8cc265",
    "yellow": "#d18f52",
    "blue": "#4aa5f0",
    "magenta": "#c162de",
    "cyan": "#42b3c2",
    "white": "#d7dae0",
    # Bright ANSI colors
    "bright_black": "#4f5666",
    "bright_red": "#ff616e",
    "bright_green": "#a5e075",
    "bright_yellow": "#f0a45d",
    "bright_blue": "#4dc4ff",
    "bright_magenta": "#de73ff",
    "bright_cyan": "#4cd1e0",
    "bright_white": "#e6e6e6",
}


def hex_to_rgb(hex_color: str) -> tuple[float, float, float]:
    """Convert hex color to RGB float values (0.0-1.0)."""
    hex_color = hex_color.lstrip("#")
    r = int(hex_color[0:2], 16) / 255.0
    g = int(hex_color[2:4], 16) / 255.0
    b = int(hex_color[4:6], 16) / 255.0
    return (r, g, b)


def create_nscolor_data(hex_color: str) -> bytes:
    """Create NSKeyedArchiver data for NSColor from hex color."""
    if not HAS_APPKIT:
        raise RuntimeError("PyObjC (AppKit) not available. Install with: pip3 install pyobjc-framework-Cocoa")

    r, g, b = hex_to_rgb(hex_color)
    color = NSColor.colorWithCalibratedRed_green_blue_alpha_(r, g, b, 1.0)
    data = NSKeyedArchiver.archivedDataWithRootObject_(color)
    return bytes(data)


def create_terminal_profile() -> dict:
    """Create Terminal.app profile dictionary."""
    profile = {
        "name": "One Dark Pro Night Flat",
        "type": "Window Settings",
        "ProfileCurrentVersion": 2.07,
        # Window settings
        "columnCount": 120,
        "rowCount": 36,
        # Cursor
        "CursorBlink": True,
        "CursorType": 1,  # 0=Block, 1=Underline, 2=Vertical Bar
        # Shell
        "shellExitAction": 1,
        # Title settings
        "ShowRepresentedURLInTitle": True,
        "ShowRepresentedURLPathInTitle": True,
        "ShowActiveProcessInTitle": True,
        "ShowDimensionsInTitle": False,
        "ShowShellCommandInTitle": False,
        "ShowWindowSettingsNameInTitle": False,
        "ShowCommandKeyInTitle": False,
        "ShowTTYNameInTitle": False,
        "ShowActiveProcessArgumentsInTitle": False,
    }

    # Add colors
    color_mappings = {
        "BackgroundColor": "background",
        "TextColor": "foreground",
        "CursorColor": "cursor",
        "SelectionColor": "selection",
        "TextBoldColor": "bold",
        "ANSIBlackColor": "black",
        "ANSIRedColor": "red",
        "ANSIGreenColor": "green",
        "ANSIYellowColor": "yellow",
        "ANSIBlueColor": "blue",
        "ANSIMagentaColor": "magenta",
        "ANSICyanColor": "cyan",
        "ANSIWhiteColor": "white",
        "ANSIBrightBlackColor": "bright_black",
        "ANSIBrightRedColor": "bright_red",
        "ANSIBrightGreenColor": "bright_green",
        "ANSIBrightYellowColor": "bright_yellow",
        "ANSIBrightBlueColor": "bright_blue",
        "ANSIBrightMagentaColor": "bright_magenta",
        "ANSIBrightCyanColor": "bright_cyan",
        "ANSIBrightWhiteColor": "bright_white",
    }

    print("Generating color data...")
    for terminal_key, color_name in color_mappings.items():
        hex_color = COLORS[color_name]
        print(f"  {terminal_key}: {hex_color}")
        profile[terminal_key] = create_nscolor_data(hex_color)

    return profile


def main():
    script_dir = Path(__file__).parent
    output_file = script_dir / "OneDarkProNightFlat.terminal"

    print("Creating One Dark Pro Night Flat Terminal theme...")
    print(f"Output: {output_file}\n")

    if not HAS_APPKIT:
        print("Error: PyObjC not available.")
        print("Install with: pip3 install pyobjc-framework-Cocoa")
        print("\nAlternatively, use the pre-generated .terminal file if available.")
        return 1

    profile = create_terminal_profile()

    with open(output_file, "wb") as f:
        plistlib.dump(profile, f)

    print(f"\nTheme saved to: {output_file}")
    print("\nTo install:")
    print("  1. Double-click the .terminal file, or")
    print("  2. Open Terminal > Settings > Profiles > Import")
    print("  3. Set as default in Terminal > Settings > General")
    return 0


if __name__ == "__main__":
    exit(main())
