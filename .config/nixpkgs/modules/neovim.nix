{ inputs, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ../config/init.vim;
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
