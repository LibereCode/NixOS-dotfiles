{ configs, pkgs, ... }:

{
    programs = {
        ashell.enable = true;

        hyprlock = {
            enable = true;
            # ...
        };
        hyprshot = {
            enable = true;
            # ...
        };

        fuzzel = {
            enable = true;
            # settings = {
            #     # ...
            # };
        };
    };
    services = {
        hypridle = {
            enable = true;
            # ...
        };
        hyprpolkitagent = {
            enable = true;
            # ...
        };
        # hyprpaper = {
        #     enable = true;
        #     # ...
        # };
        awww.enable = true; # has been renamed swww -> awww
    };
}
