# windows dev environment

### [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
```
wsl --install
```

### [fish](https://fishshell.com/) [starship](https://starship.rs/)
fish shell with starship prompt
```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

chsh -s $(which fish)

curl -sS https://starship.rs/install.sh | sh
```

### [wslu](https://github.com/wslutilities/wslu)
```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

### [WSL Hello sudo](https://github.com/nullpo-head/WSL-Hello-sudo)
```bash
wget https://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
tar xvf release.tar.gz
cd release
./install.sh
```

### [X410](https://x410.dev/)
My favourite x server for wsl2 to use linux gui apps
```bash
sudo apt install socat

echo -e "\nexport DISPLAY=:0.0\nexport SSH_AUTH_SOCK=\$HOME/.ssh/agent.sock\nexport DIRENV_LOG_FORMAT=" >> ~/.bashrc

systemctl --user enable vsock.service
```

### [npiperelay](https://github.com/jstarks/npiperelay/releases/tag/v0.1.0)
Allows to use ssh keys out of 1password from windows host with hello authentication.
Download, extract the npiperelay.exe and place it in C:\Windows\System32

### [1Password](https://1password.com/downloads/windows/)
My favourite password manager, especially with the ssh agent and windows hello authentication.
```bash
systemctl --user enable ssh-relay.service
```

### [ShareX](https://github.com/ShareX/ShareX/releases)
My favourite screenshot tool

### [Cascadia Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/)
Download the latest release. Install the windows font and set it as default in windows terminal (CaskaydiaCove NF Mono).
Copy none windows fonts to `~/.local/share/fonts`

Add emoji font aswell
```bash
sudo apt install fonts-noto-color-emoji
```

### [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/)
Install jetbrains toolbox and install your favourite jetbrains IDE inside wsl2
```bash
sudo apt install libfuse2
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
```

Windows shortcut path to start PHPStorm from windows start menu
```
C:\Windows\System32\wsl.exe -e bash -lic "~/.local/share/JetBrains/Toolbox/scripts/phpstorm > /dev/null 2>&1 &"
```

### [devenv](https://devenv.sh/)
My favourite dev setup for local development

[Shopware - Devenv](https://developer.shopware.com/docs/guides/installation/devenv)
