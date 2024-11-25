
# enable systemd in Windows Subsystem for Linux (WSL).

### edit WSL local config.

open wsl local config file (`/etc/wsl.conf`) and add the content:

```
[boot]
systemd=true
```

reboot WSL (on windows host).
```powershell
wsl --shutdown;
wsl;
```
