# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix # NOTE: sooooo impure
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking = {
        hostName = "virtualice"; # Define your hostname.
        networkmanager.enable = true; # nmcli and nmtui
        # Open ports in the firewall.
        # firewall.allowedTCPPorts = [ ... ];
        # firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # firewall.enable = false;
    };

    time.timeZone = "Europe/Stockholm"; # Set your time zone.

    i18n.defaultLocale = "en_DK.UTF-8"; # Select internationalisation properties.

    services.displayManager.ly.enable = true;
    # services.getty.autologinUser = "nixnomo";
    
    # programs.hyprland = {
    #     enable = true;
    #     # withUWSW = true;
    #     xwayland.enable = true;
    # };

    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # # Enable the X11 windowing system.
    #   services.xserver = {
    #       enable = true; 
    #       # Configure keymap in X11
    #       xkb.layout = "us";
    #       xkb.variants = "altgr-intl";
    #       xkb.options = "eurosign:e,caps:escape";
    #   };


    services = {
        printing.enable = true; # Enable CUPS to print documents.

        # Enable sound.
        # pulseaudio.enable = true;
        # OR
        pipewire = {
          enable = true;
          pulse.enable = true;
        };

        libinput.enable = true; # Enable touchpad support

        # Enable the OpenSSH daemon.
        openssh.enable = true;
    };

    users.users.nixnomo = { # Don't forget to set a password with ‘passwd’.
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };


    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment = {
        systemPackages = with pkgs; [
            # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
            neovim
            wget

            # better core-utils
            lsd
            bat
            zoxide
            ripgrep
            fd

            # other usefull
            fzf
            yazi
            pcmanfm

            # hypr (not in home-manager)
            # hyprlauncher
        ];
        pathsToLink = [ 
            "/share/applications" "/share/xdg-desktop-portal"
        ];
    };

    fonts.packages = with pkgs; [
        nerd-fonts.victor-mono
    ];

    # programs.firefox.enable = true; # LibreWolf instead

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    }; # TODO: pinentry-curses

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?

}

