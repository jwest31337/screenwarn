# ScreenWarn Configuration

**Email notifications require a working msmtp configuration.**

If using public NTFY servers, you can omit the token required for push notifications, and it will send to the publish URL of your choosing.
Running a private NTFY like a boss? Put in your own token for increased security.


## Basics

After running the ```install.sh``` script, edit the default configuration file and populate it with your values. Sane defaults are provided.

```bash
nano ~/.config/screenwarn.env
```

## SMTP (email)

ScreenWarn does not manage SMTP credentials directly.
After installing ```msmtp```, Users must configure:

~/.config/msmtp/config

*Example minimum configuration for msmtp to work correctly:*

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
