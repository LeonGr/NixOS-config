{ config, inputs, pkgs, ... }:

let
  readFile = file: ext: builtins.readFile "${file}";
  readLuaSection = file: wrapLuaConfig (readFile file "lua");

  wrapLuaConfig = luaConfig: ''
    lua<<EOF
    ${luaConfig}
    EOF
  '';
in
{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ../config/neovim/init.vim +
    readLuaSection ../config/neovim/lua/lsp.lua +
    readLuaSection ../config/neovim/lua/treesitter.lua +
    readLuaSection ../config/neovim/lua/overwrite.lua;
#      builtins.readFile ../config/neovim/init.vim +
#      "\nlua <<EOF\n" +
#      builtins.readFile ../config/neovim/lsp.lua +
#      "EOF" +
#      "\nlua <<EOF\n" +
#      builtins.readFile ../config/neovim/treesitter.lua +
#      "EOF" +
#      "\nlua <<EOF\n" +
#      builtins.readFile ../config/neovim/overwrite.lua +
#      "EOF";
    plugins = with pkgs.vimPlugins; [
       surround
       emmet-vim
       nerdtree
       vim-nerdtree-tabs
       nerdcommenter
       vim-tmux-navigator
       quick-scope
       #vim-fat-finger
       vim-repeat
       tabular
       vim-endwise
       #vim-hardtime
       vim-gitgutter
       auto-pairs
       ultisnips
       vim-snippets
       ale
       #vCoolor
       #vissort
       fzf-vim
       fzfWrapper
       vim-javascript
       vim-css-color
       #scss-syntax.vim
       vim-indent-guides
       vim-vue
       typescript-vim
       vim-jsx-typescript
       #nvim-r
       csv
       haskell-vim
       #vim-prisma
       vim-graphql
       #neovim-expand-selection
       vim-nix
       # lsp
       nvim-treesitter
       nvim-lspconfig
       #lsp_extensions
       completion-nvim
       #lsp-status
       #completion-buffers
       # colors
       gruvbox
    ];

    package = pkgs.neovim-nightly;
  };
}
