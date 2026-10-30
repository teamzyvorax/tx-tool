#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/3] Checking shell syntax..."
while IFS= read -r -d '' file; do
  bash -n "$file"
  printf '  OK %s\n' "$file"
done < <(find . -type f -name '*.sh' -not -path './.git/*' -print0)
bash -n bin/zyvorax
echo "  OK bin/zyvorax"

echo "[2/3] Loading toolkit modules..."
for file in modules/system.sh modules/network.sh modules/files.sh modules/coding.sh modules/maintenance.sh; do
  # shellcheck disable=SC1090
  source "$file"
done

for fn in system_menu network_menu files_menu coding_menu maintenance_menu; do
  declare -F "$fn" >/dev/null || { echo "Missing function: $fn" >&2; exit 1; }
  echo "  OK $fn"
done

echo "[3/3] Checking installer dependency list..."
if grep -qE 'pkg install[^\n]*iputils' install.sh; then
  echo "Unsupported iputils dependency found." >&2
  exit 1
fi
for file in bin/zyvorax modules/system.sh modules/network.sh modules/files.sh modules/coding.sh modules/maintenance.sh; do
  [[ -s "$file" ]] || { echo "Missing or empty file: $file" >&2; exit 1; }
done

echo "ZYVORAX smoke tests passed."
