# windows dev environment

### [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
```
wsl --install
```

### [Nix](https://nixos.org/download#nix-install-windows)
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
nix run home-manager/master -- switch
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"
```

### [WSL Hello sudo](https://github.com/nullpo-head/WSL-Hello-sudo)
```bash
wget https://github.com/evanphilip/WSL-Hello-sudo/releases/download/v2.1.0/release.tar.gz
tar xvf release.tar.gz
cd release
./install.sh
```

### [X410](https://x410.dev/)
My favourite x server for wsl2 to use linux gui apps

### [npiperelay](https://github.com/jstarks/npiperelay)
Allows to use ssh keys out of 1password from windows host with hello authentication.
```bash
winget install -e --id jstarks.npiperelay
winget install -e --id Discord.Discord
winget install -e --id SlackTechnologies.Slack
```

### [1Password](https://1password.com/downloads/windows/)
My favourite password manager, especially with the ssh agent and windows hello authentication.
```bash
winget install -e --id AgileBits.1Password
```

### [ShareX](https://github.com/ShareX/ShareX/releases)
My favourite screenshot tool
```bash
winget install -e --id ShareX.ShareX
```

### [Cascadia Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/)
Download the latest release. Install the windows font and set it as default in windows terminal (CaskaydiaCove NF Mono).

Add emoji font
```bash
sudo apt install fonts-noto-color-emoji
```

### [devenv](https://devenv.sh/)
My favourite dev setup for local development

[Shopware - Devenv](https://developer.shopware.com/docs/guides/installation/devenv)


### Update
```bash
nix flake update
nix run home-manager/master -- switch
```

### Tools
```bash
winget install -e --id Notepad++.Notepad++
winget install -e --id Discord.Discord
winget install -e --id SlackTechnologies.Slack
winget install -e --id tailscale.tailscale
```