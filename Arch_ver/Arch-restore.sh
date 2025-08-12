#!/bin/bash
set -e

### 🧹 Emoji Picker Restore Script – Dual-Forge Edition (Arch Version)
# This script resets the emoji-picker module to a clean, symlinked state
# assuming dotfiles contain the canonical configuration.

DOTFILES_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.config/emoji-picker"
DOTFILESLOCAL_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.local/share/applications"
DOTFILESICON_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.local/share/icons/hicolor/48x48/apps"
CONFIG_DEST="$HOME/.config/emoji-picker"
SCRIPT_DEST="$HOME/.bin/emoji-picker.sh"
SCRIPT_SOURCE="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/arch/emoji-picker/emoji-picker.sh"

# Ensure ~/.bin exists
mkdir -p "$HOME/.bin"

# Clean up old config (if present)
echo "🧹 Removing existing ~/.config/emoji-picker..."
rm -rf "$CONFIG_DEST"

# Re-link config to dotfiles
echo "🔗 Restoring config symlink..."
ln -s "$DOTFILES_PATH" "$CONFIG_DEST"

# Re-link script
echo "🔗 Restoring script symlink..."
rm -f "$SCRIPT_DEST"
ln -s "$SCRIPT_SOURCE" "$SCRIPT_DEST"
chmod +x "$SCRIPT_DEST"

# Restore .desktop launcher
echo "🎯 Restoring .desktop launcher..."
mkdir -p ~/.local/share/applications
cp "$DOTFILESLOCAL_PATH/emoji-picker.desktop" ~/.local/share/applications/emoji-picker.desktop
chmod +x ~/.local/share/applications/emoji-picker.desktop

# Restore icon
echo "🎨 Restoring icon..."
mkdir -p ~/.local/share/icons/hicolor/48x48/apps
cp "$DOTFILESICON_PATH/emoji-picker.png" ~/.local/share/icons/hicolor/48x48/apps/emoji-picker.png

# Notify user
notify-send "Emoji Picker Restored ✅" "Script, config, launcher, and icon have been restored."
echo "✅ Emoji Picker fully restored to a clean state."
exit 0
