#!/bin/bash
set -euo pipefail

# --------------------------
# Configuration
# --------------------------
DEFAULT_EMOJI_TABLE="$HOME/.config/emoji-picker/emoji.txt"
EMOJI_TABLE="${EMOJI_TABLE_PATH:-$DEFAULT_EMOJI_TABLE}"

# --------------------------
# Pre-flight checks
# --------------------------
if ! command -v wofi >/dev/null; then
    echo "Error: wofi is not installed." >&2
    exit 1
fi

if ! command -v wl-copy >/dev/null; then
    echo "Error: wl-clipboard is not installed." >&2
    exit 1
fi

if ! command -v notify-send >/dev/null; then
    echo "Warning: libnotify is not installed. Notifications will be skipped." >&2
    HAS_NOTIFY=false
else
    HAS_NOTIFY=true
fi

if [[ ! -f "$EMOJI_TABLE" ]]; then
    echo "Error: Emoji table not found at $EMOJI_TABLE" >&2
    exit 1
fi

# --------------------------
# Main logic
# --------------------------
chosen=$(cut -f1,2 "$EMOJI_TABLE" | wofi --dmenu --prompt "Emoji:" || true)

if [[ -n "${chosen:-}" ]]; then
    IFS=$'\t' read -r emoji _ <<< "$chosen"
    echo -n "$emoji" | wl-copy
    if [[ "$HAS_NOTIFY" == true ]]; then
        notify-send "✅ Copied" "$emoji copied to clipboard"
    fi
fi
