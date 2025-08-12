# 😄 Emoji Picker

## 👋 Welcome

**Emoji Picker** is a minimalist, Wayland-native emoji picker designed for fast fuzzy selection, clipboard copy, and clean KDE/Hyprland integration.  
Built to be **portable**, **declarative**, and **desktop-environment agnostic**.

Whether you’re writing code, chatting with friends, or just adding some ✨ flair ✨ to your documents, this picker puts every emoji a quick keystroke away.

It’s designed for:
- **Speed:** Instant fuzzy search by name or shortcode.
- **Simplicity:** No bloated dependencies, no daemons running in the background.
- **Integration:** Works seamlessly with your desktop environment or tiling window manager.
- **Portability:** Fully self-contained — restore or move it to any machine in seconds.

If you’ve ever wanted a clean, keyboard-driven way to add emojis to your workflow without touching the mouse, this is it.

> This module installs the emoji picker, sets up optional `.desktop` entries, and includes a tool to regenerate your emoji list from the official Unicode database. Works on any Linux distribution with Wayland support.

---

## 🎯 Purpose

To create a user-owned, fast, keyboard-driven emoji picker that:
- Works cleanly under Wayland (Kubuntu, Hyprland, GNOME, etc.)
- Avoids GTK/Qt overhead
- Respects the XDG config structure
- Can be fully restored with `install.sh` + `restore.sh`

---

## 🧱 Architecture

This repository contains:

```

emoji-picker/
├── emoji-picker.sh       # Main executable script (fuzzy search + copy)
├── gen-emoji-table.sh    # Regenerate emoji.txt from Unicode
├── install.sh            # Installs picker, dependencies, icons, and launcher
├── restore.sh            # Restores a clean, working install

config/emoji-picker/
└── emoji.txt             # Clean UTF-8 emoji list

share/applications/
└── emoji-picker.desktop  # Optional launcher file

share/icons/hicolor/48x48/apps/
└── emoji-picker.png      # Icon used in menus/launchers

```

---

## ⚙️ Dependencies

Required:
- `wofi` – Wayland fuzzy menu
- `wl-clipboard` – for `wl-copy`
- `libnotify` – for `notify-send`

`install.sh` will attempt to auto-detect your package manager and install them.  

### Manual install examples:
**Arch:**
```bash
sudo pacman -S wofi wl-clipboard libnotify
```

**Debian/Ubuntu:**

```bash
sudo apt install wofi wl-clipboard libnotify-bin
```

---

## 📦 Install

### Option A: Script (recommended)

```bash
# Clone + enter the repo
git clone https://github.com/<you>/<repo>.git
cd <repo>

# Make scripts executable (only needed once)
chmod +x install.sh restore.sh emoji-picker.sh gen-emoji-table.sh

# Run installer
./install.sh
```

> 💡 If you get a "Permission denied" error when running a script, make sure it’s executable using `chmod +x scriptname`.

### Option B: Manual

```bash
# 1) Copy the executable to a folder in your $PATH
install -m 0755 emoji-picker.sh ~/.local/bin/emoji-picker

# 2) (Optional) Install the desktop entry
mkdir -p ~/.local/share/applications
cp share/applications/emoji-picker.desktop ~/.local/share/applications/

# 3) (Optional) Install the icon
mkdir -p ~/.local/share/icons/hicolor/48x48/apps
cp share/icons/hicolor/48x48/apps/emoji-picker.png ~/.local/share/icons/hicolor/48x48/apps/

# 4) (Optional) Bind a hotkey in your DE/WM
```

---

## 🚀 Usage

Run directly:

```bash
emoji-picker
```

Or assign a global shortcut in your desktop environment (KDE, GNOME, Hyprland, etc.).

### Power users:

You can override the default emoji list location:

```bash
EMOJI_TABLE_PATH=/path/to/emoji.txt emoji-picker
```

---

## 🔄 Updating Emoji List

To fetch the latest Unicode emoji set:

```bash
./gen-emoji-table.sh
```

By default, this writes to:

```
~/.config/emoji-picker/emoji.txt
```

Override location or Unicode version:

```bash
EMOJI_TABLE_PATH=~/my_emojis.txt UNICODE_VERSION=16.0 ./gen-emoji-table.sh
```

---

## ⌨️ Hotkeys (examples)

### KDE

`System Settings → Shortcuts → Custom Shortcuts → Add Command`

```
Command/URL: ~/.local/bin/emoji-picker
```

### GNOME

`Settings → Keyboard → Keyboard Shortcuts → Custom Shortcuts`

### Hyprland

```ini
bind = $mainMod, E, exec, ~/.local/bin/emoji-picker
```

> Works with **any compositor/DE** that supports launching custom commands.

---

## 🖼️ Screenshots

<img src="docs/screenshot.png" width="520" alt="Emoji Picker search" />
<img src="docs/emoji-picker.gif" width="520" alt="Emoji Picker demo" />

---

## ♻️ Restore

If your install ever breaks or you want to reset it:

```bash
./restore.sh
```

This will restore the script, config, icon, and `.desktop` launcher.

---

## 📜 License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.

---

## 🌱 Future Ideas

* Direct injection into focused window (when supported by compositor)
* Multi-selection clipboard mode
* GUI preview for `emoji.txt` generation

---
