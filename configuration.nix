# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "red-ice"; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networkmanager.enable = true; # TODO iwd-backend

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # services.getty.autologinUser = "nixnomo";
  services = {
    displayManager.ly = {
      enable = true;
      # settings = {};
    };

    # Enable CUPS to print documents.
    # printing.enable = true;

    # Enable sound.
    # pulseaudio.enable = true;
    # OR
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  programs = {
    # wayland
    hyprland = {
      enable = true;
      # withUWSM = true;
      xwayland.enable = true;
    };

    zsh.enable = true;

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  users.users.nixnomo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment = { 
    systemPackages = with pkgs; [
      librewolf # firefox
      # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      fish
      foot
      git
      waybar
      slurp
      grim
      wl-clipboard
      kitty

      # why are these not default?
      busybox
      python315
    ];
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin"; # not official
      PATH = [
        "${XDG_BIN_HOME}"
      ];

      # Put envvar.sh here # TODO: instead do an import
      # FZF # https://github.com/junegunn/fzf
      # FZF_DEFAULT_COMMAND=""
      FZF_DEFAULT_OPTS=''
        --layout=reverse --border=sharp --margin=3% --color=dark
        --bind 'ctrl-/:change-preview-window(down|hidden|)'
      '';
      # FZF_DEFAULT_OPTS_FILE="" # ~/path/to/file-with-FZF_DEFAULT_OPTS
      FZF_CTRL_T_OPTS=''
        --walker-skip .git,node_modules,target
        --preview 'bat -n --color=always {}'
      '';
      FZF_CTRL_R_OPTS="";
      FZF_ALT_C_OPTS=''
        --walker-skip .git,node_modules,target
        --preview 'tree -C {}'
      '';
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.settings.experimental-features = [ "nix-command" ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment? # maybe?
}

