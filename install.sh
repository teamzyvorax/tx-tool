#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
BIN_DIR="$PREFIX/bin"
APP_DIR="$HOME/.zyvorax"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQUIRED_FILES=(bin/zyvorax modules/system.sh modules/network.sh modules/files.sh modules/coding.sh modules/maintenance.sh)

fail() { printf '\n[ERROR] %s\n' "$*" >&2; exit 1; }
trap 'fail "Installation stopped at line $LINENO. Fix the error above and run bash install.sh again."' ERR

[[ -n "${HOME:-}" && -d "$PREFIX" ]] || fail "Termux environment not detected."
command -v pkg >/dev/null 2>&1 || fail "The pkg command is unavailable. Open the official Termux app."

for file in "${REQUIRED_FILES[@]}"; do
  [[ -f "$ROOT_DIR/$file" ]] || fail "Required project file is missing: $file"
done

echo "========================================"
echo "       ZYVORAX ULTRA INSTALLER"
echo "========================================"
echo "Step 1/3: Refreshing package indexes..."
pkg update

echo
echo "Step 2/3: Installing required packages..."
# Keep this list to packages available in the standard Termux main repository.
pkg install -y bash coreutils findutils zip unzip tar curl iproute2 procps python git

echo
echo "Step 3/3: Installing ZYVORAX files..."
mkdir -p "$APP_DIR/modules" "$BIN_DIR"
install -m 755 "$ROOT_DIR/bin/zyvorax" "$APP_DIR/zyvorax"
for file in system.sh network.sh files.sh coding.sh maintenance.sh; do
  install -m 644 "$ROOT_DIR/modules/$file" "$APP_DIR/modules/$file"
done

cat > "$BIN_DIR/zyvorax" <<'LAUNCHER'
#!/data/data/com.termux/files/usr/bin/bash
exec "$HOME/.zyvorax/zyvorax" "$@"
LAUNCHER
chmod 755 "$BIN_DIR/zyvorax"

[[ -x "$BIN_DIR/zyvorax" ]] || fail "Launcher verification failed."
[[ -x "$APP_DIR/zyvorax" ]] || fail "Main program verification failed."

echo
echo "[SUCCESS] ZYVORAX ULTRA installed."
echo "Start it with: zyvorax"
echo "If command is not found, run: hash -r"
echo "Optional battery support: install the Termux:API Android app, then run: pkg install termux-api"
