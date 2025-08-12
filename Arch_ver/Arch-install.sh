#!/bin/bash
set -e

### Emoji Picker Installer – Dual-Forge Edition

# CONFIGURE YOUR PATHS BELOW
DOTFILESCONFIG_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.config/emoji-picker"
DOTFILESLOCAL_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.local/share/applications"
DOTFILESICON_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/dotfiles/.local/share/icons/hicolor/48x48/apps"
MODULE_PATH="$HOME/G-Drive/JoelOS/100-Projects/P006-DualForge/arch/emoji-picker"
SCRIPT_PATH="$MODULE_PATH/emoji-picker.sh"
CONFIG_DEST="$HOME/.config/emoji-picker"
SCRIPT_DEST="$HOME/.bin/emoji-picker.sh"

# Ensure dependencies
echo "🔧 Installing dependencies..."
sudo pacman -S --noconfirm fzf wl-clipboard jq

echo "🔧 Avoiding redundant installs..."
for pkg in fzf wl-clipboard jq; do
  if ! pacman -Q $pkg >/dev/null 2>&1; then
    echo "Installing $pkg..."
    sudo pacman -S --noconfirm $pkg
  else
    echo "$pkg is already installed."
  fi
done

# Ensure ~/.bin exists
mkdir -p "$HOME/.bin"

# Link the script
echo "🔗 Linking picker script to $SCRIPT_DEST"
ln -sf "$SCRIPT_PATH" "$SCRIPT_DEST"
chmod +x "$SCRIPT_DEST"

# Link config folder
echo "🔗 Linking emoji config from dotfiles to $CONFIG_DEST"
rm -rf "$CONFIG_DEST"
ln -s "$DOTFILESCONFIG_PATH" "$CONFIG_DEST"

# Copy .desktop launcher
cp "$DOTFILESLOCAL_PATH/emoji-picker.desktop" ~/.local/share/applications/emoji-picker.desktop

# Set .desktop launcher file as executable
chmod +x ~/.local/share/applications/emoji-picker.desktop

# Copy icon file
mkdir -p ~/.local/share/icons/hicolor/48x48/apps
cp "$DOTFILESICON_PATH/emoji-picker.png" ~/.local/share/icons/hicolor/48x48/apps/emoji-picker.png

# Done
notify-send "✅ Emoji Picker Installed" "Linked to $SCRIPT_DEST"
echo "✅ Emoji Picker successfully installed and linked."
echo "🎯 Remember to assign a global shortcut to run: $SCRIPT_DEST"
echo "✅ Emoji picker installed for Arch!"
