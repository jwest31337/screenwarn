#!/usr/bin/env bash

set -euo pipefail

echo "[*] Uninstalling screenwarn..."

#
# Stop and disable service
#

systemctl --user disable --now screenwarn.service 2>/dev/null || true

#
# Remove installed files
#

rm -f "$HOME/.local/bin/screenwarn-watch"
rm -f "$HOME/.local/bin/screenwarn-capture"

rm -f "$HOME/.config/systemd/user/screenwarn.service"

#
# Reload systemd
#

systemctl --user daemon-reload

echo
echo "[+] screenwarn removed"
echo
echo "Preserved:"
echo "  ~/.config/screenwarn.env"
echo "  ~/.local/share/screenwarn"
echo "  ~/.local/state/screenwarn"
echo
echo "Remove these manually if desired."
