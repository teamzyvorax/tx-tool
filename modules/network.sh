network_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== NETWORK DIAGNOSTICS ==="
    echo "1. Check internet connectivity"
    echo "2. Ping a host (if ping is installed)"
    echo "3. DNS lookup"
    echo "4. Show network interfaces"
    echo "5. Show public IP"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1) if curl -fsSI --max-time 8 https://example.com >/dev/null; then echo "Internet connection: OK"; else echo "Connection failed or timed out."; fi ;;
      2)
        if ! command -v ping >/dev/null 2>&1; then
          echo "The ping utility is not installed in this Termux repository. Use option 1 for an HTTPS connectivity test."
        else
          read -r -p "Host (default: 1.1.1.1) > " host
          host="${host:-1.1.1.1}"
          ping -c 4 "$host"
        fi
        ;;
      3)
        read -r -p "Domain > " domain
        if [[ -n "$domain" ]]; then
          if command -v nslookup >/dev/null 2>&1; then nslookup "$domain"
          elif command -v getent >/dev/null 2>&1; then getent hosts "$domain"
          else echo "No DNS lookup utility found."; fi
        fi
        ;;
      4) ip addr 2>/dev/null || ifconfig 2>/dev/null || echo "No interface utility found." ;;
      5) curl -fsS --max-time 10 https://api.ipify.org || echo "Could not fetch public IP."; echo ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
