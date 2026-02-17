# Floating Hebrew Clock (macOS, terminal-first)

A transparent floating **Hebrew word clock** for macOS (Intel or Apple Silicon) using SwiftUI + AppKit.

## What it does

- Stays above other windows (`floating` level)
- Transparent / glass-like bubble look
- Draggable by default (move it anywhere on screen)
- Resizable from corners/edges
- Always-on-top transparent bubble style
- Shows digital HH:mm:ss above a one-line Hebrew sentence
- Appears on all Spaces and alongside fullscreen apps

## Requirements (no Xcode app needed)

You can run everything from **VS Code + terminal**. You do **not** need to open Xcode.

- macOS 13+
- Apple Command Line Tools (`xcode-select --install`)
- Swift toolchain available in terminal (`swift --version`)

## Quick start from terminal

From this repo directory:

```bash
./run.sh
```

Or directly:

```bash
swift run -c release FloatingHebrewClock
```

## Verify your environment (one-time)

```bash
xcode-select -p
swift --version
```

If `xcode-select -p` fails, install command line tools:

```bash
xcode-select --install
```

> Note: Apple currently ships SwiftUI/AppKit SDKs through Apple's developer tools, so CLT is required even when you don't use the Xcode UI.

## Simple run + test steps

1. Open terminal in this project folder.
2. Check tools:
   ```bash
   xcode-select -p
   swift --version
   ```
3. Run the app:
   ```bash
   ./run.sh
   ```
4. Test that it works:
   - You should see a transparent floating bubble clock on screen.
   - It should stay on top.
   - You should be able to drag the bubble across the screen.
   - You should be able to resize it from the corners/edges.
   - Wait a few seconds and confirm the one-line Hebrew text updates every second.
5. Stop the app with `Ctrl + C` in terminal.

## Troubleshooting (common setup issues)

### Dragging and resizing

This version is draggable by default and supports resizing from corners/edges.

If dragging/resizing does not respond, make sure you replaced **both**:
- `Sources/FloatingHebrewClock/App.swift`
- `run.sh`

### `@main` conflict mentioning `main.swift`

If you see an error like:

```
'@main' attribute cannot be used in a module that contains top-level code
```

and the path includes `Sources/FloatingHebrewClock/main.swift`, just run:

```bash
./run.sh
```

`run.sh` now auto-migrates old projects from `main.swift` to `App.swift` before building.

### `zsh: parse error near ')'`

That usually happens when pasting numbered instructional text (for example lines like `1)` / `2)`) directly into terminal.

Use only plain commands, one block at a time:

```bash
cd ~/HebClock
chmod +x run.sh
./run.sh
```

## Customize behavior

Main places to tweak:

- Window behavior (`always on top`, click-through, all spaces):
  - `Sources/FloatingHebrewClock/App.swift`
- Hebrew time wording logic:
  - `Sources/FloatingHebrewClock/HebrewTimeFormatter.swift`

### Useful toggles

In `App.swift`, you can change:

- `panel.isMovable = true` and `panel.isMovableByWindowBackground = true`
  - allows dragging by default
- `styleMask` includes `.resizable`
  - enables corner/edge resizing
- `panel.level = .floating`
  - keeps it above regular windows

## Notes about Hebrew phrasing

Hebrew time phrasing has many stylistic variants. Current implementation uses a minimal/slangy one-line format **with נִקּוּד**, without "השעה", and with connector rules that match spoken style:

- For `:15` use `וָרֶבַע` (example: `שְׁתֵּים עֶשְׂרֵה וָרֶבַע בַּצָּהֳרַיִים`)
- For `:30` use `וָחֵצִי` (example: `שְׁתֵּים עֶשְׂרֵה וָחֵצִי בַּצָּהֳרַיִים`)
- For exact tens (`:20`, `:40`, etc.) no connector between hour and minute phrase (example: `שְׁתֵּים עֶשְׂרֵה עֶשְׂרִים בַּצָּהֳרַיִים`)
- Otherwise use `ו` before the minute phrase (example: `שְׁתֵּים עֶשְׂרֵה וְשָׁלוֹשׁ עֶשְׂרֵה בַּצָּהֳרַיִים`)
- `חֲצוֹת` exactly at `00:00`

You can tweak day-part ranges and wording in `HebrewTimeFormatter.words(from:)`.
