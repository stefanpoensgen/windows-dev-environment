# windows dev environment

### [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
```
wsl --install
```

### [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)
Install docker desktop for windows and enable wsl2 integration

### [X410](https://x410.dev/)
My favourite x server for wsl2 to use linux gui apps
```
echo 'export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0' >> ~/.profile
```

### [Google Chrome](https://www.google.com/intl/en_us/chrome/)
Install google chrome for windows as daily driver and inside wsl2 for dependency reasons
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

### [npiperelay](https://github.com/jstarks/npiperelay/releases/tag/v0.1.0)
Allows to use ssh keys out of 1password from windows host with hello authentication.
Download, extract the npiperelay.exe and place it somewhere in your PATH.
```
sudo apt install socat
```
Add to ~/.bashrc
```
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

### [1Password](https://1password.com/downloads/windows/)
My favourite password manager, especially with the ssh agent and windows hello authentication.

### [ShareX](https://github.com/ShareX/ShareX/releases)
My favourite screenshot tool

### [Cascadia Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/)
Download the latest release. Install the windows font and set it as default in windows terminal (CaskaydiaCove NF Mono).
Copy none windows fonts to `~/.local/share/fonts`

### [Jetbrains Toolbox](https://www.jetbrains.com/toolbox-app/)
Install jetbrains toolbox and install your favourite jetbrains IDE inside wsl2
```
curl https://gist.githubusercontent.com/greeflas/431bc50c23532eee8a7d6c1d603f3921/raw | bash
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

mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/craver.omp.json)"' >> ~/.bashrc
```

### [WSL Hello sudo](https://github.com/nullpo-head/WSL-Hello-sudo)
```
wget https://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
tar xvf release.tar.gz
cd release
./install.sh
```

### [Shopware Docker by shyim](https://github.com/shyim/shopware-docker)
My favourite shopware docker setup for local development
```
git clone https://github.com/shyim/shopware-docker.git ~/Documents/shopware-docker
sudo ln -s /home/$USER/Documents/shopware-docker/swdc /usr/local/bin/swdc
echo 'source "$HOME/Documents/shopware-docker/completion.sh"' >> ~/.bashrc
```
