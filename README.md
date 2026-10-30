# ZYVORAX ULTRA

**A modular, menu-driven utility toolkit for Termux on Android.**

[![ZYVORAX CI](https://github.com/teamzyvorax/tx-tool/actions/workflows/ci.yml/badge.svg)](https://github.com/teamzyvorax/tx-tool/actions/workflows/ci.yml)

ZYVORAX is an independent shell toolkit. It does not replace Termux, change Android security settings, root your phone, or run hidden background tasks.

## Install

Open Termux and run:

```bash
pkg update
pkg install git -y
git clone https://github.com/teamzyvorax/tx-tool.git
cd tx-tool
bash install.sh
hash -r
zyvorax
```

## Features

- **System:** Android/Termux, kernel, architecture, storage and memory information
- **Network:** HTTPS connectivity, optional ping, DNS lookup, network interfaces and public IP
- **Files:** filename search, ZIP creation, safe ZIP extraction without overwriting, timestamped folder backups
- **Developer:** create starter Python/HTML projects, run a local Python web server, clone HTTPS GitHub repositories
- **Maintenance:** update package indexes, confirm before upgrades/cache cleanup, list installed packages
- **Optional battery status:** supported through the separate Termux:API Android app and package

## Requirements

- A maintained Termux installation (F-Droid or official GitHub releases)
- Internet access and the standard Termux main package repository
- Optional: Termux:API Android app plus `pkg install termux-api`

## Update

```bash
cd ~/tx-tool
git pull
bash install.sh
hash -r
```

## Uninstall

```bash
bash ~/tx-tool/uninstall.sh
```

The uninstaller removes the ZYVORAX launcher and `~/.zyvorax` application files. It does not remove Termux or packages installed as dependencies.

## Troubleshooting

If a package cannot be found, first refresh the Termux mirror selection and package indexes:

```bash
termux-change-repo
pkg update
```

Then retry:

```bash
cd ~/tx-tool
git pull
bash install.sh
```

If `zyvorax` is not found after installation, run `hash -r` or restart Termux.

## Development checks

GitHub Actions checks shell syntax and runs the repository smoke tests on pushes and pull requests to `main`. Run the same smoke test locally with:

```bash
bash tests/smoke.sh
```

## Safety

- No root access is required.
- No hidden background process or automatic package upgrade runs when the toolkit starts.
- System upgrades and cache cleanup require explicit confirmation.
- ZIP extraction uses `unzip -n` to avoid overwriting existing files.
- Only test devices and networks you own or are authorized to use.

## License

MIT. See [LICENSE](LICENSE).
