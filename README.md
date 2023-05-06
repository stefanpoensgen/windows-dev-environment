# windows dev environment

### [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
```
wsl --install
```

### [WSL Hello sudo](https://github.com/nullpo-head/WSL-Hello-sudo)
```
wget https://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
tar xvf release.tar.gz
cd release
./install.sh
```

### [X410](https://x410.dev/)
My favourite x server for wsl2 to use linux gui apps
```
sudo apt install socat
echo 'export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0' >> ~/.profile
```

Add to ~/.bashrc
```shell
# Configure vsock for x410
export VSOCK=/tmp/.X11-unix/X0
VSOCK_ALREADY_RUNNING=$(pgrep -f "VSOCK-CONNECT:2:6000" &>/dev/null; echo $?)
if [[ $VSOCK_ALREADY_RUNNING != "0" ]]; then
    if [[ -S $VSOCK ]]; then
        echo "removing previous socket..."
        rm $VSOCK
    fi
    echo "Starting VSOCK-CONNECT ..."
    (setsid socat -b65536 UNIX-LISTEN:$VSOCK,fork,mode=777 VSOCK-CONNECT:2:6000 &) >/dev/null 2>&1
fi
```

### [npiperelay](https://github.com/jstarks/npiperelay/releases/tag/v0.1.0)
Allows to use ssh keys out of 1password from windows host with hello authentication.
Download, extract the npiperelay.exe and place it somewhere in your PATH.

Add to ~/.bashrc
```shell
# Configure ssh forwarding
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
# need `ps -ww` to get non-truncated command for matching
# use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
if [[ $ALREADY_RUNNING != "0" ]]; then
    if [[ -S $SSH_AUTH_SOCK ]]; then
        # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
        echo "removing previous socket..."
        rm $SSH_AUTH_SOCK
    fi
    echo "Starting SSH-Agent relay..."
    # setsid to force new session to keep running
    # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi
```

### [Google Chrome](https://www.google.com/intl/en_us/chrome/)
Install google chrome for windows as daily driver and inside wsl2 for dependency reasons
```
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmour -o /usr/share/keyrings/google_linux_signing_key.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google_linux_signing_key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo apt update
sudo apt install google-chrome-stable
```

### [1Password](https://1password.com/downloads/windows/)
My favourite password manager, especially with the ssh agent and windows hello authentication.

### [ShareX](https://github.com/ShareX/ShareX/releases)
My favourite screenshot tool

### [Cascadia Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/)
Download the latest release. Install the windows font and set it as default in windows terminal (CaskaydiaCove NF Mono).
Copy none windows fonts to `~/.local/share/fonts`

Add emoji font aswell
```
sudo apt install fonts-noto-color-emoji
```

### [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/)
Install jetbrains toolbox and install your favourite jetbrains IDE inside wsl2
```
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
```

Windows shortcut path to start PHPStorm from windows start menu
```
C:\Windows\System32\wsl.exe -e bash -lic "~/.local/share/JetBrains/Toolbox/scripts/phpstorm > /dev/null 2>&1 &"
```

### [Oh My Posh](https://ohmyposh.dev/docs/installation/linux)
My favourite prompt theme engine
```
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

mkdir ~/.config
wget https://raw.githubusercontent.com/stefanpoensgen/windows-dev-environment/main/stefan.omp.json -O ~/.config/stefan.omp.json

echo 'eval "$(oh-my-posh init bash --config ~/.config/stefan.omp.json)"' >> ~/.bashrc
```

### [devenv](https://devenv.sh/)
My favourite dev setup for local development

[Shopware - Devenv](https://developer.shopware.com/docs/guides/installation/devenv)
