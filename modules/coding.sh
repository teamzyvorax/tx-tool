coding_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== DEVELOPER TOOLS ==="
    echo "1. Create Python project"
    echo "2. Create HTML project"
    echo "3. Start local web server"
    echo "4. Clone Git repository"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1)
        read -r -p "Project folder name > " name
        if [[ -n "$name" && ! -e "$name" ]]; then
          mkdir -p "$name"
          printf 'def main():\n    print("Hello from ZYVORAX!")\n\nif __name__ == "__main__":\n    main()\n' > "$name/main.py"
          printf '# %s\n\nPython project created with ZYVORAX ULTRA.\n' "$name" > "$name/README.md"
          echo "Created: $name"
        else echo "Name is empty or folder already exists."; fi
        ;;
      2)
        read -r -p "Project folder name > " name
        if [[ -n "$name" && ! -e "$name" ]]; then
          mkdir -p "$name"
          cat > "$name/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>ZYVORAX Web Project</title></head>
<body><main><h1>Hello from ZYVORAX ULTRA</h1><p>Your project is ready.</p></main></body>
</html>
HTML
          echo "Created: $name/index.html"
        else echo "Name is empty or folder already exists."; fi
        ;;
      3)
        read -r -p "Web root folder [.] > " dir
        dir="${dir:-.}"
        read -r -p "Port [8000] > " port
        port="${port:-8000}"
        if [[ -d "$dir" && "$port" =~ ^[0-9]{1,5}$ ]] && ((port>=1024 && port<=65535)); then
          echo "Open http://127.0.0.1:$port on this device. Press Ctrl+C to stop."
          python -m http.server "$port" --directory "$dir"
        else echo "Invalid folder or port."; fi
        ;;
      4)
        read -r -p "Git repository URL > " url
        [[ "$url" =~ ^https://github\.com/[^[:space:]]+\.git$|^https://github\.com/[^[:space:]]+$ ]] && git clone "$url" || echo "Enter a valid HTTPS GitHub URL."
        ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
