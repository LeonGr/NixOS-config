{ config, pkgs, ... }:

let
    homeDirectory = "/home/leon";
in
{
    imports = [
        ./modules/git.nix
        ./modules/neovim.nix
        ./modules/zsh.nix
        ./modules/polybar.nix
        ./modules/rofi.nix
        ./modules/tmux.nix
        ./modules/zathura.nix
    ];

    xdg.enable = true;
    xdg.configHome = "${homeDirectory}/.config";
    xdg.dataHome = "${homeDirectory}/.local/share";
    xdg.cacheHome = "${homeDirectory}/.cache";
    xdg.userDirs = {
        desktop = "\$HOME";
        documents = "\$HOME";
    };

    xdg.configFile = {
        "zathura/zathurarc".source = "${config.xdg.cacheHome}/wal/zathurarc";
    };

    home = {
        username = "leon";
        homeDirectory = homeDirectory;
        language.base = "en_US.UTF-8";
        stateVersion = "20.09";

        file = {
            # templates for pywal
            "${config.xdg.configHome}/wal/templates/colors-rofi.rasi".source = ./config/wal_templates/colors-rofi.template;
            "${config.xdg.configHome}/wal/templates/zathurarc".source = ./config/wal_templates/zathurarc.template;
            "${config.xdg.configHome}/wal/templates/dunstrc".source = ./config/wal_templates/dunstrc.template;
        };
    };

    programs.home-manager = {
        enable = true;
    };
}
