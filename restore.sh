#!/bin/bash
set -e

### 🧹 Emoji Picker Restore Script – Public Release
# Resets Emoji Picker to a clean, working state using files from this repo.
# Can also be used after moving to a new machine to restore configs and assets.

# --------------------------
# PATH CONFIGURATION
# --------------------------
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_SRC="$REPO_DIR/emoji-picker.sh"
CONFIG_SRC="$REPO_DIR/dotfiles/.config/emoji-picker"
DESKTOP_SRC="$REPO_DIR/dotfiles/.local/share/applications/emoji-picker.desktop"
ICON_SRC="$REPO_DIR/dotfiles/.local/share/icons/hicolor/48x48/apps/emoji-picker.png"

SCRIPT_DEST="$HOME/.local/bin/emoji-picker"
CONFIG_DEST="$HOME/.config/emoji-picker"
DESKTOP_DEST="$HOME/.local/share/applications/emoji-picker.desktop"
ICON_DEST="$HOME/.local/share/icons/hicolor/48x48/apps/emoji-picker.png"

# --------------------------
# RESTORE FUNCTIONS
# --------------------------

restore_config() {
    echo "🧹 Removing existing config at $CONFIG_DEST..."
    rm -rf "$CONFIG_DEST"

    if [ -d "$CONFIG_SRC" ]; then
        echo "🔗 Restoring config from repo to $CONFIG_DEST"
        cp -r "$CONFIG_SRC" "$CONFIG_DEST"
    else
        echo "⚠️ No config found at $CONFIG_SRC — skipping."
    fi
}

restore_script() {
    mkdir -p "$HOME/.local/bin"
    if [ -f "$SCRIPT_SRC" ]; then
        echo "🔗 Restoring script to $SCRIPT_DEST"
        install -m 0755 "$SCRIPT_SRC" "$SCRIPT_DEST"
    else
        echo "⚠️ No script found at $SCRIPT_SRC — skipping."
    fi
}

restore_desktop_entry() {
    if [ -f "$DESKTOP_SRC" ]; then
        mkdir -p "$(dirname "$DESKTOP_DEST")"
        echo "🎯 Restoring .desktop launcher to $DESKTOP_DEST"
        install -m 0644 "$DESKTOP_SRC" "$DESKTOP_DEST"
    else
        echo "ℹ️ No .desktop file found — skipping."
    fi
}

restore_icon() {
    if [ -f "$ICON_SRC" ]; then
        mkdir -p "$(dirname "$ICON_DEST")"
        echo "🎨 Restoring icon to $ICON_DEST"
        install -m 0644 "$ICON_SRC" "$ICON_DEST"
    else
        echo "ℹ️ No icon file found — skipping."
    fi
}

# --------------------------
# MAIN EXECUTION
# --------------------------
restore_config
restore_script
restore_desktop_entry
restore_icon

if command -v notify-send >/dev/null 2>&1; then
    notify-send "✅ Emoji Picker Restored" "Script, config, launcher, and icon have been restored."
fi

echo "✅ Emoji Picker fully restored to a clean state."
