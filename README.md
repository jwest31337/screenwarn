# screenwarn

**KDE Plasma failed-unlock intrusion notifier for Linux laptops.**

[![License: AGPLv3](https://img.shields.io/badge/License-AGPLv3-blue.svg)](LICENSE)
[![Shell Script](https://img.shields.io/badge/language-Shell_Script-yellow.svg)](https://www.shellscript.sh/)
[![KDE Plasma](https://img.shields.io/badge/Platform-KDE_Plasma-1f425f.svg)](https://kde.org/plasma-desktop/)
[![GitHub release](https://img.shields.io/github/v/release/jwest31337/screenwarn)](https://github.com/jwest31337/screenwarn/releases)

Features:
- Detects failed KDE lockscreen unlock attempts
- Webcam footage capture of attacker
- GIF preview
- NTFY alert capabilities
- Email alert capabilities
- Local evidence archiver
- Runs as user-level systemd service!

Status:
Early development, probably shouldn't be used as a production service.

Email notifications require a working msmtp configuration.

screenwarn does not manage SMTP credentials directly.
After installing msmtp, Users must configure:

~/.config/msmtp/config

Example minimum configuration for msmtp to work correctly:

```bash
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.yourhost.com
port 587
from youremail@example.com
user youremail@example.com
password ExamplePassword123
```

Additionally, ```chmod 600 ~/.config/msmtp/config``` to protect the SMTP credentials by changing permissions to lock it down.


Dependencies:
- bash
- ffmpeg
- curl
- mutt
- msmtp
- msmtp-mta
- NetworkMManager (nmcli)
- systemd
- KDE Plasma
