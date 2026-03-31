{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ashell
      kitty
      rofi
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true; # maybe unnecessary?
    extraConfig = ''# extraConfig = appended (to end)
source = ~/.config/hyprland/test.conf
    '';
  
    settings = {
      # variables
      "$mod" = "SUPER";
      "$term" = "kitty -1";
      "$web" = "librewolf";
      "$menu" = "rofi -show drun";
      "$fileManager" = "pcmanfm";
  
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
  
      bind = [
	"$mod, f, fullscreen, 1"
        "$mod, t, togglefloating"
        "$mod, q, killactive"
        #
        "$mod, Return, exec, $term"
        "$mod, b, exec, $web"
	"$mod, e, exec, $fileManager"
	"$mod, Space, exec, $menu"
        #
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
	#
	"$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
	"$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
	# Example special workspace (scratchpad)
        "$mod, s, togglespecialworkspace, scratchpad"
        "$mod SHIFT, s, movetoworkspace, special:scratchpad"
      ];
  
      input = {
        # xkb
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_model = "";
        kb_options = "caps:escape";
        kb_rules = "";
      };
  
      exec-once = [
        "kitty -1 --start-as hidden --hold"
          "ashell" # TODO enable/install bluetooth, upower
      ];
  
      decoration = {
        # shadow_offset = "0.5";
        # "col.shadow" = "rgba(00000099)";
      };
    };
  };
}
