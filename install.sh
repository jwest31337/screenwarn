#!/usr/bin/env bash

set -euo pipefail

echo "[*] Installing screenwarn..."

#
# Dependency checks
#

missing=()

for cmd in \
    ffmpeg \
    curl \
    journalctl \
    systemd-run \
    mutt \
    msmtp
do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if (( ${#missing[@]} > 0 )); then
    echo
    echo "ERROR: Missing dependencies:"
    printf ' - %s\n' "${missing[@]}"
    echo
    echo "Please install required packages and re-run install.sh"
    exit 1
fi

#
# Create directories
#

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/systemd/user"
mkdir -p "$HOME/.local/share/screenwarn"
mkdir -p "$HOME/.local/state/screenwarn"

#
# Install binaries
#

install -m 755 \
    bin/screenwarn-watch \
    "$HOME/.local/bin/screenwarn-watch"

install -m 755 \
    bin/screenwarn-capture \
    "$HOME/.local/bin/screenwarn-capture"

#
# Install systemd service
#

install -m 644 \
    systemd/screenwarn.service \
    "$HOME/.config/systemd/user/screenwarn.service"

#
# Install config template if missing
#

if [[ ! -f "$HOME/.config/screenwarn.env" ]]; then

    install -m 600 \
        config/screenwarn.env.example \
        "$HOME/.config/screenwarn.env"

    echo
    echo "[*] Installed default config:"
    echo "    ~/.config/screenwarn.env"

fi

#
# Reload and enable systemd service
#

systemctl --user daemon-reload
systemctl --user enable --now screenwarn.service

echo
echo "[+] screenwarn installation complete"
echo
echo "Next steps:"
echo "1. Edit ~/.config/screenwarn.env"
echo "2. Configure NTFY and/or email"
echo "3. Verify ~/.config/msmtp/config if using email alerts"
echo
echo "Check service status:"
echo "  systemctl --user status screenwarn.service"
