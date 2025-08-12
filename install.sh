#!/bin/bash
set -e

### Emoji Picker Installer – Public Release

# --------------------------
# CONFIGURATION
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

DEPENDENCIES=("wofi" "wl-clipboard" "libnotify")

# --------------------------
# FUNCTIONS
# --------------------------

install_deps() {
    echo "🔧 Checking dependencies..."
    local missing_pkgs=()
    for pkg in "${DEPENDENCIES[@]}"; do
        if ! command -v "$pkg" >/dev/null 2>&1; then
            missing_pkgs+=("$pkg")
        fi
    done

    if [ ${#missing_pkgs[@]} -eq 0 ]; then
        echo "✅ All dependencies already installed."
        return
    fi

    echo "📦 Installing missing packages: ${missing_pkgs[*]}"

    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --needed "${missing_pkgs[@]}"
    elif command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y "${missing_pkgs[@]/libnotify/libnotify-bin}"
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y "${missing_pkgs[@]}"
    elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y "${missing_pkgs[@]}"
    else
        echo "⚠️ Unsupported package manager. Please install manually: ${missing_pkgs[*]}"
    fi
}

link_script() {
    mkdir -p "$HOME/.local/bin"
    echo "🔗 Installing script to $SCRIPT_DEST"
    install -m 0755 "$SCRIPT_SRC" "$SCRIPT_DEST"
}

link_config() {
    if [ -d "$CONFIG_SRC" ]; then
        mkdir -p "$(dirname "$CONFIG_DEST")"
        rm -rf "$CONFIG_DEST"
        echo "🔗 Copying emoji config to $CONFIG_DEST"
        cp -r "$CONFIG_SRC" "$CONFIG_DEST"
    else
        echo "⚠️ No config directory found at $CONFIG_SRC — skipping."
    fi
}

install_desktop_entry() {
    if [ -f "$DESKTOP_SRC" ]; then
        mkdir -p "$(dirname "$DESKTOP_DEST")"
        echo "🔗 Installing desktop entry to $DESKTOP_DEST"
        install -m 0644 "$DESKTOP_SRC" "$DESKTOP_DEST"
    else
        echo "ℹ️ No .desktop file found — skipping."
    fi
}

install_icon() {
    if [ -f "$ICON_SRC" ]; then
        mkdir -p "$(dirname "$ICON_DEST")"
        echo "🔗 Installing icon to $ICON_DEST"
        install -m 0644 "$ICON_SRC" "$ICON_DEST"
    else
        echo "ℹ️ No icon file found — skipping."
    fi
}

# --------------------------
# MAIN SCRIPT
# --------------------------
install_deps
link_script
link_config
install_desktop_entry
install_icon

if command -v notify-send >/dev/null 2>&1; then
    notify-send "✅ Emoji Picker Installed" "Ready to use from: $SCRIPT_DEST"
fi

echo "✅ Emoji Picker successfully installed."
echo "🎯 Assign a global shortcut to run: $SCRIPT_DEST"
