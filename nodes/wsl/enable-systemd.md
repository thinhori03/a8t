
# enable systemd in Windows Subsystem for Linux (WSL).

### edit WSL local config.

the wsl local config file: `/etc/wsl.conf`

the content is

```
[boot]
systemd=true
```

reboot WSL (on windows host).
```powershell
wsl --shutdown;
wsl;
```
