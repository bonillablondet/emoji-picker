#!/bin/bash

OUT_FILE="$HOME/.config/emoji-picker/emoji.txt"
mkdir -p "$(dirname "$OUT_FILE")"

curl -sSL https://unicode.org/Public/emoji/15.0/emoji-test.txt \
  | grep -v '^#' \
  | grep 'fully-qualified' \
  | sed -E 's/.*; fully-qualified.*# ([^ ]+) (.+)/\1\t\2/' \
  | sed -E 's/ /_/g' \
  > "$OUT_FILE"

echo "✅ Emoji table written to: $OUT_FILE"
