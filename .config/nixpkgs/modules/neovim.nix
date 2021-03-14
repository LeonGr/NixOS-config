{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ../config/init.vim;
    plugins = with pkgs.vimPlugins; [
       ale
    ];
  };
}
