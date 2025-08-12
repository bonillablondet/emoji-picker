#!/bin/bash

EMOJI_TABLE="$HOME/.config/emoji-picker/emoji.txt"
chosen=$(cut -f1,2 "$EMOJI_TABLE" | wofi --dmenu --prompt "Emoji:")

if [[ -n "$chosen" ]]; then
    IFS=$'\t' read -r emoji _ <<< "$chosen"
    echo -n "$emoji" | wl-copy
    notify-send "Copied $emoji to clipboard"
fi
