#!/usr/bin/env swift
//
// Generate macOS Terminal.app theme from One Dark Pro Night Flat color palette
// Matches Cursor/VS Code theme colors
//

import AppKit
import Foundation

// One Dark Pro Night Flat color palette
let colors: [String: String] = [
    "background": "#16191d",
    "foreground": "#abb2bf",
    "cursor": "#528bff",
    "selection": "#677696",
    "bold": "#e6e6e6",
    // Normal ANSI
    "black": "#3f4451",
    "red": "#e05561",
    "green": "#8cc265",
    "yellow": "#d18f52",
    "blue": "#4aa5f0",
    "magenta": "#c162de",
    "cyan": "#42b3c2",
    "white": "#d7dae0",
    // Bright ANSI
    "bright_black": "#4f5666",
    "bright_red": "#ff616e",
    "bright_green": "#a5e075",
    "bright_yellow": "#f0a45d",
    "bright_blue": "#4dc4ff",
    "bright_magenta": "#de73ff",
    "bright_cyan": "#4cd1e0",
    "bright_white": "#e6e6e6"
]

func hexToColor(_ hex: String) -> NSColor {
    let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)
    let r = CGFloat((int >> 16) & 0xFF) / 255.0
    let g = CGFloat((int >> 8) & 0xFF) / 255.0
    let b = CGFloat(int & 0xFF) / 255.0
    return NSColor(calibratedRed: r, green: g, blue: b, alpha: 1.0)
}

func colorToData(_ color: NSColor) -> Data {
    return try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
}

let colorMappings: [String: String] = [
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
    "ANSIBrightWhiteColor": "bright_white"
]

var profile: [String: Any] = [
    "name": "One Dark Pro Night Flat",
    "type": "Window Settings",
    "ProfileCurrentVersion": 2.07,
    "columnCount": 120,
    "rowCount": 36,
    "CursorBlink": true,
    "CursorType": 1,
    "shellExitAction": 1,
    "ShowRepresentedURLInTitle": true,
    "ShowRepresentedURLPathInTitle": true,
    "ShowActiveProcessInTitle": true,
    "ShowDimensionsInTitle": false,
    "ShowShellCommandInTitle": false,
    "ShowWindowSettingsNameInTitle": false,
    "ShowCommandKeyInTitle": false,
    "ShowTTYNameInTitle": false,
    "ShowActiveProcessArgumentsInTitle": false
]

print("Creating One Dark Pro Night Flat Terminal theme...")
print("Generating color data...")

for (terminalKey, colorName) in colorMappings {
    guard let hex = colors[colorName] else { continue }
    print("  \(terminalKey): \(hex)")
    let color = hexToColor(hex)
    profile[terminalKey] = colorToData(color)
}

// Get script directory
let scriptPath = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()
let outputPath = scriptPath.appendingPathComponent("OneDarkProNightFlat.terminal")

do {
    let data = try PropertyListSerialization.data(fromPropertyList: profile, format: .xml, options: 0)
    try data.write(to: outputPath)
    print("\nTheme saved to: \(outputPath.path)")
    print("\nTo install:")
    print("  1. Double-click the .terminal file, or")
    print("  2. Open Terminal > Settings > Profiles > Import")
    print("  3. Set as default in Terminal > Settings > General")
} catch {
    print("Error: \(error)")
    exit(1)
}
