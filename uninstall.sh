#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
echo "This removes the ZYVORAX launcher and files in ~/.zyvorax."
read -r -p "Continue? [y/N] " answer
case "$answer" in
  y|Y|yes|YES)
    rm -f "$PREFIX/bin/zyvorax"
    rm -rf "$HOME/.zyvorax"
    echo "ZYVORAX removed."
    ;;
  *) echo "Cancelled."; exit 0 ;;
esac
