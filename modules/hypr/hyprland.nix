{ configs, pkgs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        settings = {
            # monitor

            monitor = ",1600x900@60.000,auto,1";

            # confvar

            "$term" = "kitty -1";
            "$fm" = "pcmanfm";
            "$menu" = "fuzzel";

            # autostart

            exec-once = [
                "ashell"
                "awww-daemon & disown"
                "kitty -1 --start-as hidden"
            ];

            # envvar

            env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
            ];

            # Permissions

            # Look n feel 

            general = {
                gaps_in = "10";
                gaps_out = "20";
                border_size = "2";

                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                resize_on_border = "true";

                allow_tearing = "false";

                layout = "dwindle";
            };

            decoration = {
                rounding = "10";
                rounding_power = "2";

                active_opacity = "1.0";
                inactive_opacity = "0.9";

                shadow = {
                    enabled = "true";
                    range = "4";
                    render_power = "3";
                    color = "rgba(1a1a1aee)";
                };

                blur = {
                    enabled = "true";
                    size = "3";
                    passes = "1";

                    vibrancy = "0.1696";
                };
            };

            animations = {
                enabled = "yes, please :)"; # lol what?

                bezier = [
                    # name      X0, Y0, X1, Y1
                    "easeOutQuint, 0.23, 1, 0.32, 1"
                    "easeInQuintCubic, 0.65, 0.05, 0.36, 1"
                    "linear, 0, 0, 1, 1"
                    "almostLinear, 0.5, 0.5, 0.75, 1"
                    "quick, 0.15, 0, 0.1, 1"
                ];

                animation = [
                # NAME,ONOFF,SPEED,CURVE,[STYLE]
                    "global, 1, 10, default"
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                    "zoomFactor, 1, 7, quick"
                ];
            };

            dwindle = {
                pseudotile = "true";
                preserve_split = "true";
            };

            master = {
                new_status = "master";
            };

            misc = {
                force_default_wallpaper = "-1"; # 0|1 = disable anime wallpaper
                disable_hyprland_logo = "false"; # true = disable hypr-anime-gurl
            };

            # Input

            input = {
                kb_layout = "us";
                kb_variant = "altgr-intl";
                kb_model = "";
                kb_options = "caps:escape";
                kb_rules = "";
                # TODO: add compose

                repeat_delay = 234; # time until
                repeat_rate = 39;   # time between

                follow_mouse = 1;

                sensitivity = 0; # -1.0 -> 1.0

                touchpad = {
                    natural_scroll = true;
                };
            }; 

            gesture = [
                "3, horizontal, workspace"
            ];

            device = {
                name = "epic-mouse-v1";
                sensitivity = "-0.5";
            };

            # KeyBinds

            "$mod" = "SUPER"; # "ALT"; "SUPER"; (SUPER+mouse work weird in virtual machine, use ALT for that instead)

            bind = [
                "$mod, Return, exec, $term"
                "$mod, Q, killactive,"
                "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
                "$mod, E, exec, $fm"
                "$mod, T, togglefloating,"
                "$mod, Space, exec, $menu"
                "$mod, P, pseudo," # dwindle (is what?)
                # "$mod, J, layoutmsg, togglesplit" # dwindle

                "$mod, H, movefocus, l"
                "$mod, J, movefocus, d"
                "$mod, K, movefocus, u"
                "$mod, L, movefocus, r"

                "$mod, S, togglespecialworkspace, magic"
                "$mod SHIFT, S, movetoworkspace, special:magic"

                "$mod, U, workspace, e-1"
                "$mod, I, workspace, e+1"

                "$mod, mouse_down, workspace, e-1"
                "$mod, mouse_up, workspace, e+1"
            ]
            ++ ( # workspaces
            builtins.concatLists (builtins.genList (i:
                let ws = i + 1;
                in [
                    "$mod, code:1${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]) 9)
            );

            bindm = [ # WARN: Can't be Super in a virt-machine
                "ALT, mouse:272, movewindow"
                "ALT, mouse:273, resizewindow"
            ];

            bindel = [ # TODO: wpctl
                ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, bightnessctl -e4 -n2 set 5%+"
                ",XF86MonBrightnessDown, exec, bightnessctl -e4 -n2 set 5%-"
            ];
            bindl = [ # TODO: playerctl
                ",XF86AudioNext, exec, playerctl next"
                ",XF86AudioPause, exec, playerctl play-pause"
                ",XF86AudioPlay, exec, playerctl play-pause"
                ",XF86AudioPrev, exec, playerctl previous"
            ];

            # Rules (windows/workspaces)

            windowrule = [ # prehaps move to `extraConfig` ?
                {
                    name = "suppress-maximize-events";
                    "match:class" = ".*";
                    suppress_event = "maximize";
                }
                {
                    name = "fix-xwayland-drags";
                    "match:class" = "^$";
                    "match:title" = "^$";
                    "match:xwayland" = "true";
                    "match:float" = "true";
                    "match:fullscreen" = "false";
                    "match:pin" = "false";
                    no_focus = "true";
                }
                {
                    name = "move-hyprland-run";
                    "match:class" = "hyprland-run";
                    move = "20 monitor_h-120";
                    float = "yes";
                }
            ];
        };

        # extraConfig = ''
        # '';
    };
}
