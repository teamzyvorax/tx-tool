files_menu() {
  while true; do
    clear 2>/dev/null || true
    echo "=== FILE TOOLS ==="
    echo "1. Find files by name"
    echo "2. Create ZIP archive"
    echo "3. Extract ZIP safely (no overwrite)"
    echo "4. Backup a folder"
    echo "0. Back"
    read -r -p "Select > " c
    case "$c" in
      1)
        read -r -p "Search folder [HOME] > " dir
        dir="${dir:-$HOME}"
        read -r -p "Name pattern (e.g. *.py) > " pattern
        [[ -d "$dir" && -n "$pattern" ]] && find "$dir" -type f -name "$pattern" -print 2>/dev/null || echo "Invalid folder or pattern."
        ;;
      2)
        read -r -p "Folder/file to archive > " src
        read -r -p "Output ZIP path > " out
        if [[ -e "$src" && -n "$out" && ! -e "$out" ]]; then zip -r "$out" "$src"; else echo "Source missing or output already exists."; fi
        ;;
      3)
        read -r -p "ZIP file > " archive
        read -r -p "Destination folder > " dest
        if [[ -f "$archive" && -n "$dest" ]]; then
          mkdir -p "$dest"
          unzip -n "$archive" -d "$dest"
        else echo "Archive not found."; fi
        ;;
      4)
        read -r -p "Folder to back up > " src
        read -r -p "Backup destination folder > " dest
        if [[ -d "$src" && -n "$dest" ]]; then
          mkdir -p "$dest"
          name="$(basename "$src")_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
          tar -czf "$dest/$name" -C "$(dirname "$src")" "$(basename "$src")" && echo "Saved: $dest/$name"
        else echo "Folder not found."; fi
        ;;
      0) return ;;
      *) echo "Invalid option." ;;
    esac
    read -r -p "Press Enter..." _
  done
}
