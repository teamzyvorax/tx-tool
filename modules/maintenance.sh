maintenance_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== MAINTENANCE ==="
    echo "1. Update package lists"
    echo "2. Upgrade installed packages"
    echo "3. Clean package cache"
    echo "4. List installed packages"
    echo "5. Show package count"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1) pkg update ;;
      2)
        echo "This may download and upgrade many packages."
        read -r -p "Continue? [y/N] " ok
        [[ "$ok" == y || "$ok" == Y ]] && pkg upgrade
        ;;
      3)
        read -r -p "Clean downloaded package cache? [y/N] " ok
        [[ "$ok" == y || "$ok" == Y ]] && apt clean
        ;;
      4) pkg list-installed ;;
      5) dpkg-query -W -f='\${binary:Package}\n' 2>/dev/null | wc -l ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
