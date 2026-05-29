#!/usr/bin/env bash

set -euo pipefail

echo "[*] Installing screenwarn..."

#
# Dependency checks
#

missing=()

for cmd in \
    ffmpeg \
    ffprobe \
    curl \
    journalctl \
    systemd-run \
    nmcli \
    mutt \
    msmtp
do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if (( ${#missing[@]} > 0 )); then

    echo
    echo "ERROR: Missing required dependencies:"
    printf '  - %s\n' "${missing[@]}"
    echo
    echo "Please install the missing packages and re-run install.sh"
    echo
    exit 1

fi

#
# Create required directories
#

echo "[*] Creating directories..."

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/systemd/user"
mkdir -p "$HOME/.local/share/screenwarn"
mkdir -p "$HOME/.local/share/screenwarn/events"
mkdir -p "$HOME/.local/state/screenwarn"

#
# Install binaries
#

echo "[*] Installing binaries..."

install -m 755 \
    bin/screenwarn-watch \
    "$HOME/.local/bin/screenwarn-watch"

install -m 755 \
    bin/screenwarn-capture \
    "$HOME/.local/bin/screenwarn-capture"

#
# Install systemd service
#

echo "[*] Installing systemd service..."

install -m 644 \
    systemd/screenwarn.service \
    "$HOME/.config/systemd/user/screenwarn.service"

#
# Install config template if missing
#

if [[ ! -f "$HOME/.config/screenwarn.env" ]]; then

    echo "[*] Installing default configuration..."

    install -m 600 \
        config/screenwarn.env.example \
        "$HOME/.config/screenwarn.env"

    echo
    echo "[+] Created:"
    echo "    ~/.config/screenwarn.env"

else

    echo "[*] Existing configuration detected; preserving it."

fi

#
# Reload systemd user manager
#

echo "[*] Reloading systemd user units..."

systemctl --user daemon-reload

#
# Enable and start service
#

echo "[*] Enabling screenwarn.service..."

systemctl --user enable --now screenwarn.service

#
# Verify installation
#

if systemctl --user is-enabled screenwarn.service >/dev/null 2>&1; then
    echo "[+] screenwarn.service enabled"
else
    echo "[!] Warning: unable to verify service enablement"
fi

if systemctl --user is-active screenwarn.service >/dev/null 2>&1; then
    echo "[+] screenwarn.service running"
else
    echo "[!] Warning: service does not appear to be running"
fi

#
# Completion message
#

echo
echo "[+] screenwarn installation complete"
echo
echo "Next steps:"
echo
echo "  1. Edit ~/.config/screenwarn.env"
echo
echo "  2. Configure notification methods:"
echo "       - NTFY"
echo "       - Email"
echo
echo "  3. If using email notifications:"
echo "       Configure ~/.config/msmtp/config"
echo "       Ensure permissions are restricted:"
echo
echo "           chmod 600 ~/.config/msmtp/config"
echo
echo "Useful commands:"
echo
echo "  Service status:"
echo "      systemctl --user status screenwarn.service"
echo
echo "  Follow service logs:"
echo "      journalctl --user -u screenwarn.service -f"
echo
echo "  View watcher log:"
echo "      tail -f ~/.local/state/screenwarn/watcher.log"
echo
echo "  View handler log:"
echo "      tail -f ~/.local/state/screenwarn/handler.log"
echo
echo "  Latest event:"
echo "      ls -la ~/.local/share/screenwarn/latest"
echo
