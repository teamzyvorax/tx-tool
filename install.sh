#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
BIN_DIR="$PREFIX/bin"
APP_DIR="$HOME/.zyvorax"

if [[ -z "${HOME:-}" || ! -d "$PREFIX" ]]; then
  echo "ERROR: This installer must be run inside Termux."
  exit 1
fi

mkdir -p "$APP_DIR/modules" "$BIN_DIR"
cp "$ROOT_DIR/bin/zyvorax" "$APP_DIR/zyvorax"
cp "$ROOT_DIR/modules/"*.sh "$APP_DIR/modules/"
chmod 755 "$APP_DIR/zyvorax" "$APP_DIR/modules/"*.sh

cat > "$BIN_DIR/zyvorax" <<'LAUNCHER'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/.zyvorax/zyvorax" "$@"
LAUNCHER
chmod 755 "$BIN_DIR/zyvorax"

echo
echo "ZYVORAX ULTRA installed successfully."
echo "Run: zyvorax"
echo "Optional battery support: pkg install termux-api, then install the Termux:API Android app."
