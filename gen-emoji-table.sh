#!/bin/bash
set -euo pipefail

# --------------------------
# Configuration
# --------------------------
UNICODE_VERSION="${UNICODE_VERSION:-15.0}"
OUT_FILE="${EMOJI_TABLE_PATH:-$HOME/.config/emoji-picker/emoji.txt}"

# --------------------------
# Pre-flight checks
# --------------------------
if ! command -v curl >/dev/null; then
    echo "Error: curl is not installed." >&2
    exit 1
fi

# Ensure output directory exists
mkdir -p "$(dirname "$OUT_FILE")"

# --------------------------
# Download and parse
# --------------------------
echo "📥 Fetching emoji list (Unicode v$UNICODE_VERSION)..."
curl -sSL "https://unicode.org/Public/emoji/$UNICODE_VERSION/emoji-test.txt" \
  | grep -v '^#' \
  | grep 'fully-qualified' \
  | sed -E 's/.*; fully-qualified.*# ([^ ]+) (.+)/\1\t\2/' \
  > "$OUT_FILE"

echo "✅ Emoji table written to: $OUT_FILE"
