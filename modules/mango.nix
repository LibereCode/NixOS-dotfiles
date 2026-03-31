{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      wl-clipboard
      grim
      slurp

    ];
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal
        xdg-desktop-portal-gnome
      ];
      config = {
        mango = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          "org.freedesktop.impl.portal.Inhibit" = [ "none" ];
        };
      };
    };
  };

  programs = {
    foot = { # terminal
      enable = true;
      server.enable = true;
    };
    fuzzel = { # menu-selector
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/foot";
          layer = "overlay";
        };
        colors.background = "332211dd";
      };
    };
    # rofi = {
    #   enable = true;
    #   # ...
    # };
    waybar = { # status-bar
      enable = true;
      # settings = {
      # };
      # style = ''
      # '';
      # systemd.enable = true;
    };
    wlogout = { # logout menu
      enable = true;
    };
  };
  services = {
    cliphist = {
      enable = true;
      # extraOptions = [];
    };
    wl-clip-persist = {
      enable = true;
      extraOptions = [
        "--reconnect-tries"
	"0"
      ];
    };
    gnome-keyring.enable = true;
    dunst = { # notification daemon
      enable = true;
      # icon theme
      # settings
    };
    swww = { # wallpaper
      enable = true;
    };
    wlsunset = { # night-light
      enable = true;
      latitude = 55.0;
      longitude = 13.0;
    };
  };

  wayland.windowManager.mango = {
    enable = true;
    # NOTE: I will use a regular import instead. The options isn't good enough
    #
    # settings = import ./config.nix;
    # extraCommands = import ./extraCommands.nix # run after D-Bus activation
    # xdgAutostart = import ./xdgAutostart.nix # `man systemd-xdg-autostart-generator.8`
    # autostart_sh = import ./autostart.nix;
  };
}
