{ config, pkgs, ... }:

{
    programs.rofi = {
        enable = true;
        theme = "${config.xdg.cacheHome}/wal/colors-rofi.rasi";
    };
}
