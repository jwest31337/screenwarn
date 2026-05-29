# screenwarn

KDE Plasma failed-unlock intrusion notifier for Linux laptops.

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
