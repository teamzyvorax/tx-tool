system_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== DEVICE & SYSTEM ==="
    echo "1. Basic device information"
    echo "2. Storage and memory"
    echo "3. Battery status (Termux:API)"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1)
        echo "Date: $(date)"
        echo "Android: ${ANDROID_VERSION:-unknown}"
        echo "Architecture: $(uname -m)"
        echo "Kernel: $(uname -sr)"
        echo "Hostname: $(hostname 2>/dev/null || echo unknown)"
        echo "Termux prefix: ${PREFIX:-unknown}"
        ;;
      2) df -h "$HOME" 2>/dev/null; echo; free -h 2>/dev/null || echo "Memory details unavailable on this device." ;;
      3)
        if command -v termux-battery-status >/dev/null 2>&1; then termux-battery-status
        else echo "Install Termux:API app and run: pkg install termux-api"; fi
        ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
