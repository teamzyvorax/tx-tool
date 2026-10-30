# ZYVORAX ULTRA

**A modular, menu-driven utility toolkit for Termux on Android.**

ZYVORAX is an independent shell toolkit. It does not replace Termux, change Android security settings, root your phone, or run hidden background tasks.

## Install

Open Termux and run:

```bash
pkg update
pkg install git -y
git clone https://github.com/teamzyvorax/tx-tool.git
cd tx-tool
bash install.sh
```

Start it with:

```bash
zyvorax
```

If the command is not found, close and reopen Termux, or run `hash -r`.

## Features

- Device and Termux system information
- Network diagnostics: connectivity, DNS, public IP and interfaces
- File utilities: search, archive extraction/creation and backups
- Developer tools: create Python/HTML projects, start a local HTTP server, clone Git repositories
- Maintenance: update packages, clean package cache and list installed packages
- Optional Termux:API battery information

## Requirements

- Termux from a maintained source (F-Droid or the official GitHub releases)
- Internet connection for installation and package updates
- Optional: Termux:API app plus the `termux-api` package for battery status

## Update

```bash
cd ~/tx-tool
git pull
bash install.sh
```

## Uninstall

```bash
bash ~/tx-tool/uninstall.sh
```

## Safety

Commands that install packages, update the system, or delete package caches are shown in the menu and require user selection. File extraction avoids overwriting existing files. Backups are copied to a timestamped folder under the destination you choose. Review paths before confirming operations.

ZYVORAX ULTRA is provided as-is. Use network and device tools only on systems and networks you own or are authorized to test.

## License

MIT. See [LICENSE](LICENSE).
