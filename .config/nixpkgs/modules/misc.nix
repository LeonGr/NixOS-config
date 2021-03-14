{ config, pkgs, ... }:

{
    programs = {
        zathura = { enable = true; };
    };

    services = {
        dunst = { enable = true; };
    };
}
