{ config, pkgs, lib, jetbrains, devenv, froshpkgs, ... }:

let
  socket = "${config.home.homeDirectory}/.ssh/agent.sock";
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.wslu
    pkgs.socat
    pkgs.xdg-utils
    pkgs.cascadia-code
    pkgs.unzip
    pkgs.noto-fonts-color-emoji

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
	pkgs.devenv
	froshpkgs.packages.${pkgs.system}.shopware-cli
	jetbrains.packages.${pkgs.system}.jetbrains.phpstorm
	jetbrains.packages.${pkgs.system}.fsnotifier
	pkgs.jetbrains-mono
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/stefan/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    DISPLAY = ":0.0";
	DIRENV_LOG_FORMAT = "";
	BROWSER = "wslview";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
	enable = true;
	loginShellInit = ''
	  fish_add_path /home/stefan/.nix-profile/bin
	  fish_add_path /nix/var/nix/profiles/default/bin
	  set fish_greeting
	'';
	interactiveShellInit = ''
	  fish_add_path /home/stefan/.nix-profile/bin
	  fish_add_path /nix/var/nix/profiles/default/bin
	  set fish_greeting
	'';
  };

  programs.starship = {
    enable = true;
    settings = {
      container = {
        disabled = true;
      };
      battery = {
        disabled = true;
      };
      username = {
        show_always = true;
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
	flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      workspaces = true;
      update_check = false;
      history_filter_mode = "global";
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  nixpkgs.config.allowUnfree = true;

  systemd.user.services.vsock = {
    Unit = {
      Description = "X410 VSock";
    };
    Service = {
    ExecStart = "${pkgs.writeShellScript "start-proxy" ''
        /bin/mkdir -p /tmp/.X11-unix
        /bin/rm -f /tmp/.X11-unix/X0
        ${pkgs.socat}/bin/socat -b65536 UNIX-LISTEN:/tmp/.X11-unix/X0,fork,mode=777 VSOCK-CONNECT:2:6000
    ''}";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.ssh-proxy = {
    Unit = {
      Description = "WSL Proxy";
    };
    Service = {
    ExecStart = "${pkgs.writeShellScript "start-proxy" ''
        rm -f ${socket}
        mkdir -p $(dirname ${socket})
        setsid ${pkgs.socat}/bin/socat UNIX-LISTEN:${socket},fork EXEC:"/mnt/c/Users/stefan/AppData/Local/Microsoft/WinGet/Packages/jstarks.npiperelay_Microsoft.Winget.Source_8wekyb3d8bbwe/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork
    ''}";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.sessionVariables.SSH_AUTH_SOCK = socket;
  systemd.user.sessionVariables.SSH_AUTH_SOCK = socket;
}
