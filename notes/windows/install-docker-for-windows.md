## install docker for Windows Home

- enable features (using powershell):

```shell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

- setup distro:

```shell

# list distro supported by WSL
$ wsl --list --online  # or wsl -l -o

# install linux distro: for <distro-name> see `$ wsl -l -o`
$ wsl --install -d <distro-name>

# set <distro-name> as default. Now when you run `$ wsl` wsl will start  <distro-name> for you
$ wsl -s <distro-name>

# set wsl version to 2
$ wsl --set-default-version 2
$ wsl --update

```

- install podman to distro:
```shell
$ sudo apt-get install -y podman
```
