#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="Sources/FloatingHebrewClock"
LEGACY_ENTRY="$TARGET_DIR/main.swift"
NEW_ENTRY="$TARGET_DIR/App.swift"

if [[ -f "$LEGACY_ENTRY" && ! -f "$NEW_ENTRY" ]]; then
  echo "Detected legacy entry file: $LEGACY_ENTRY"
  echo "Renaming to: $NEW_ENTRY"
  mv "$LEGACY_ENTRY" "$NEW_ENTRY"
fi

if [[ -f "$LEGACY_ENTRY" && -f "$NEW_ENTRY" ]]; then
  echo "Both $LEGACY_ENTRY and $NEW_ENTRY exist."
  echo "Please remove one of them (keep App.swift)."
  exit 1
fi

echo "Building and running FloatingHebrewClock..."
swift run -c release FloatingHebrewClock
