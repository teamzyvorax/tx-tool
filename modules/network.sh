network_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== NETWORK DIAGNOSTICS ==="
    echo "1. Check HTTPS internet connectivity"
    echo "2. Ping a host (optional utility)"
    echo "3. DNS lookup"
    echo "4. Show network interfaces"
    echo "5. Show public IP"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1)
        if curl -fsSI --connect-timeout 5 --max-time 10 https://example.com >/dev/null; then
          echo "Internet connection: OK"
        else
          echo "HTTPS check failed. Check your connection or Termux mirror."
        fi
        ;;
      2)
        if ! command -v ping >/dev/null 2>&1; then
          echo "ping is not installed in this Termux setup."
          echo "Use option 1 for an HTTPS connectivity test."
        else
          read -r -p "Host [1.1.1.1] > " host
          host="${host:-1.1.1.1}"
          ping -c 4 "$host"
        fi
        ;;
      3)
        read -r -p "Domain > " domain
        if [[ -z "$domain" ]]; then
          echo "A domain is required."
        elif command -v nslookup >/dev/null 2>&1; then
          nslookup "$domain"
        elif command -v getent >/dev/null 2>&1; then
          getent hosts "$domain" || echo "No DNS record found."
        else
          echo "No DNS lookup utility is installed. Install dnsutils if available: pkg install dnsutils"
        fi
        ;;
      4)
        if command -v ip >/dev/null 2>&1; then ip addr
        else echo "iproute2 is not installed."; fi
        ;;
      5)
        curl -fsS --connect-timeout 5 --max-time 10 https://api.ipify.org || echo "Could not fetch public IP."
        echo
        ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
