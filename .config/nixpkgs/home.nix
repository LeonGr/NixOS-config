{ config, pkgs, ... }:

let
    homeDirectory = "/home/leon";
in
{
    imports = [
        ./modules/neovim.nix
        ./modules/zsh.nix
    ];

    xdg.enable = true;
    xdg.configHome = "${homeDirectory}/.config";
    xdg.dataHome = "${homeDirectory}/.local/share";
    xdg.cacheHome = "${homeDirectory}/.cache";
    xdg.userDirs = {
        desktop = "\$HOME";
        documents = "\$HOME";
    };

    home.username = "leon";
    home.homeDirectory = homeDirectory;
    home.language.base = "en_US.UTF-8";
    home.stateVersion = "20.09";

    programs.home-manager = {
        enable = true;
    };
}
