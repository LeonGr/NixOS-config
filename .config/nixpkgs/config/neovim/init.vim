"     __                     _          _       _ __        _
"    / /   ___  ____  ____  /_/_____   (_)___  (_) /__   __(_)___ ___
"   / /   / _ \/ __ \/ __ \   / ___/  / / __ \/ / __/ | / / / __ `__ \
"  / /___/  __/ /_/ / / / /  (__  )  / / / / / / /__| |/ / / / / / / /
" /_____/\___/\____/_/ /_/  /____/  /_/_/ /_/_/\__(_)___/_/_/ /_/ /_/

set nocompatible " be iMproved, required
"filetype off     " required

" Show commands as they're typed
set showcmd

" Highlight current line
set cursorline

" Turn of swap files
set noswapfile

" Show substitute in real time
set inccommand=nosplit

" Color configurations
" if (has("termguicolors"))
"     set termguicolors
" endif

" Enable file type identification, plugin and indenting
filetype plugin indent on

" Color settings
syntax enable
syntax on
" "set t_Co=256
" " let g:gruvbox_italic=1 " urxvt supports italics, enable it
" colorscheme gruvbox

" Make line nr and background fit terminal background
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE

" Hide(0)/Only for more than 1 window(1)/Show(2) statusline
set laststatus=2

" Statusline for when it is visible
set statusline=%{StatuslineGit()}\ \ %0.50F\ %=%l,%c\ \ %p%%\ %{StatusLineLsp()}\  " comment so we don't have trailing whitespace
highlight StatusLine   gui=none            " guibg=none
highlight StatusLineNC gui=none cterm=bold " guibg=grey guifg=#000000

" Use wal colors for statusline
source ~/.cache/wal/colors-wal.vim
execute 'highlight StatusLine guifg='   . background
execute 'highlight StatusLine guibg='   . color2
execute 'highlight StatusLineNC guifg=' . foreground
execute 'highlight StatusLineNC guibg=' . color0

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0 ? '  '.l:branchname.'' : ''
endfunction

function! StatusLineLsp()
    let l:ls = LspStatus()
    return strlen(l:ls) > 0 ? ' '.l:ls : ''
endfunction

" Line numbers
set number relativenumber

highlight CursorLineNR guibg=NONE guifg=NONE

" SideLine
set signcolumn=yes                       " always show (to prevent jump from git/lint)
highlight SignColumn guibg=NONE gui=bold " Make background transparent

" Hide vertical split background color
highlight VertSplit guibg=NONE

" Stop automatic new line of comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Searching improvements
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       " ...unless uppercase letters used

set hlsearch        "Highlight all matches
"highlight clear Search
highlight Search guifg=#000000 guibg=#FFFFFF
nmap <silent> <BS> :nohlsearch<CR> " Backspace to turn of highlight Searching

" Use undofile for persistent undo
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

" use backspace
set backspace=2

" Leader commands
let mapleader = "\<Space>"

nnoremap <Leader>; g;
nnoremap <Leader>, g,
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>t :b#<CR>
vnoremap <Leader>c :'<,'>w !pbcopy<CR>  <CR>
nnoremap <Leader>s :vertical resize 120<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Lines<CR>
nnoremap <Leader>g :GFiles?<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>r :Rg<CR>
nnoremap <Leader>/ :BLines<CR>
nnoremap <Leader>v :call TrimWhiteSpace()<CR>
nnoremap <Leader>q :copen<CR>
     map <Leader>n <plug>NERDTreeTabsToggle<CR>
     map <Leader>m :ExpSel<CR>

" Instead of going to next occurrence of word on *, stay on current
nnoremap * *N

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Make alt-<hjkl> act as arrows in fzf window
function ArrowMap()
    tnoremap <M-h> <left>
    tnoremap <M-j> <down>
    tnoremap <M-k> <up>
    tnoremap <M-l> <right>
endfunction

autocmd! FileType fzf call ArrowMap()

" Let FZF be a floating window
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
    " Original
    "let buf = nvim_create_buf(v:false, v:true)
    "call setbufvar(buf, '&signcolumn', 'no')

    "let height = &lines - 3
    "let width = float2nr(&columns - (&columns * 2 / 10))
    "let col = float2nr((&columns - width) / 2)

    "let opts = {
        "\ 'relative': 'editor',
        "\ 'row': 1,
        "\ 'col': col,
        "\ 'width': width,
        "\ 'height': height
        "\ }

    "let win = nvim_open_win(buf, v:true, opts)
    "call setwinvar(win, '&relativenumber', 0)

    "let width = min([&columns - 4, max([80, &columns - 20])])
    "let height = min([&lines - 4, max([20, &lines - 10])])

    " With Border
    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    "let top = "╭" . repeat("─", width - 2) . "╮"
    "let mid = "│" . repeat(" ", width - 2) . "│"
    "let bot = "╰" . repeat("─", width - 2) . "╯"
    let top = "╔" . repeat("═", width - 2) . "╗"
    let mid = "║" . repeat(" ", width - 2) . "║"
    let bot = "╚" . repeat("═", width - 2) . "╝"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:FloatingQFOpen = 0
function! FloatingQuickfix(timer)
    if g:FloatingQFOpen == 0
        " Because FloatingQuickfix calls cclose and copen it  would trigger the autocmd again,
        " so we set this variable to 1 to stop creating an infinite loop
        let g:FloatingQFOpen = 1

        "let height = &lines - 3
        "let width = float2nr(&columns - (&columns * 2 / 10))
        "let col = float2nr((&columns - width) / 2)
        "let opts = { 'relative': 'editor', 'row': 1, 'col': col, 'width': width, 'height': height }

        let height = &lines - 3
        let width = float2nr(&columns - (&columns * 2 / 10))
        let top = ((&lines - height) / 2) - 1
        let left = (&columns - width) / 2
        let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

        "let top = "╭" . repeat("─", width - 2) . "╮"
        "let mid = "│" . repeat(" ", width - 2) . "│"
        "let bot = "╰" . repeat("─", width - 2) . "╯"
        let top = "╔" . repeat("═", width - 2) . "╗"
        let mid = "║" . repeat(" ", width - 2) . "║"
        let bot = "╚" . repeat("═", width - 2) . "╝"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating

        let buf = nvim_create_buf(v:false, v:true)
        call setbufvar(buf, '&signcolumn', 'no')

        " Close and open QF window so bn opens it instead of the file we're editing
        cclose | copen

        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4

        " Open floating window
        let win = nvim_open_win(buf, v:true, opts)
        " Set content to QF buffer | close original QF window
        bn | cclose

        " Make transparent
        set winhl=Normal:Floating
        " If we leave the buffer, close the floating window and reset the variable
        autocmd BufLeave * ++once :bd! | let g:FloatingQFOpen = 0 | echo '' | exe 'bw '.s:buf
        " After opening, show message in highlight style of ModeMsg
        echohl ModeMsg | echo ' -- QUICKFIX -- ' | echohl None
    endif
endfunction

" Call opening function after 1ms delay, otherwise neovim complains that we cannot use cclose yet
autocmd BufWinEnter quickfix call timer_start(1, 'FloatingQuickfix', {'repeat': 1})

" Close quickfix window on escape
nmap <silent><expr> <esc> (&buftype == "quickfix" ? ':bd<CR>' : '<esc>')

" Tern for vim settings
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

" Nerd Tree settings
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeShowHidden = 1

" Auto pairs settings
let g:AutoPairsShortcutToggle = '<M-p>'
"let g:AutoPairsMapCR=1

"vCoolor settings
let g:vcoolor_map = '<M-z>'

" HardTime settings
let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>", "w", "b", "e"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_maxcount = 4
let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*", "help" ]

"Retain indentation on next line
set autoindent
"Turn on autoindenting of blocks
set smartindent

" Number of spaces that a Tab is
set tabstop=4
" Number of spaces for indent (>>, <<)
set shiftwidth=4
" Pressing tab creates number of spaces
set expandtab

" Show trailing whitespace
set list listchars=tab:»·,trail:-

" Some css complete thing I guess is needed
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" Completion settings
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ completion#trigger_completion()

inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" : "\<S-Tab"

" Make <CR> select completion work with auto-pairs and endwise
let g:completion_confirm_key = ""
inoremap <expr> <CR> <SID>CRInsert()

    " return pumvisible() ? \"\<Plug>(completion_confirm_completion)" : \"\<CR>"
function! s:CRInsert()
    return pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Change color popup menu
highlight Pmenu ctermbg=gray guibg=#202020 guifg=#FFFFFF
highlight NormalFloat ctermbg=none guibg=none

" Set completeopt to have a better completion experience (:help completeopt)
    " menuone: popup even when there's only one match
    " noinsert: Do not insert text until a selection is made
    " noselect: Do not select, force user to select one from the menu
"set completeopt=noinsert,menuone,noselect
set completeopt=menuone,noselect

" Set Ultisnips/snippets expansion key
let g:UltiSnipsExpandTrigger       = "<c-s>"
let g:UltiSnipsJumpForwardTrigger  = "<c-l>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

"" (require checks file in ~/.config/nvim/lua)
"" LSP settings
"lua require('lsp')
"" TreeSitter settings
"lua require('treesitter')
"" Overwrite some functions
"lua require('overwrite')

" LSP mappings
" Jump to definition
nnoremap gf    <cmd>lua vim.lsp.buf.definition()<CR>
" Displays hover information in floating window
nnoremap K     <cmd>lua vim.lsp.buf.hover()<CR>
" Lists implementations in quickfix window
nnoremap gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" Displays signature information in floating window
nnoremap gs    <cmd>lua vim.lsp.buf.signature_help()<CR>
" Jump to definition of type
nnoremap 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" Lists all the references in quickfix window
nnoremap gr    <cmd>lua vim.lsp.buf.references()<CR>
" Lists all symbols current buffer in quickfix window
nnoremap g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" Lists all symbols current workspace in quickfix window
nnoremap gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" Jump to declaration
nnoremap gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" Selects a code action from input list available
nnoremap ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Goto previous/next diagnostic warning/error
nnoremap gj <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap gk <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" Show diagnostic popup
nnoremap <Leader>d <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Avoid showing extra messages when using completion
set shortmess+=c

" completion-nvim - Autocomplete
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_on_delete = 1 " Show suggestions after removing characters
let g:completion_trigger_keyword_length = 1 " After how many characters it should show suggestions
"let g:completion_chain_complete_list = {
"\   'default' : {
"\       'default' : [
"\           {'complete_items': ['buffers', 'lsp', 'snippet']},
"\           {'mode': '<c-p>'},
"\           {'mode': '<c-n>'}
"\       ],
"\       'string' : [
"\           { 'mode': 'file' },
"\       ]
"\   },
"\}
let g:completion_chain_complete_list = [
    \{'complete_items': ['buffers', 'lsp', 'snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
" \ lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "Comment" }

" Statusline
function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        try
            return luaeval("vim.lsp.buf_get_clients()[1].name")
        catch
            return 'LSP: '
        endtry
    endif

    return ''
endfunction

" ALE - Asynchronous Linter Engine settings

"highlight link ALEError Error
"highlight Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
"highlight link ALEWarning Warning
"highlight link ALEInfo SpellCap

nnoremap <Leader>e :call ale#cursor#ShowCursorDetail()<CR>
nnoremap <silent> <Leader>j :ALENextWrap<CR>
nnoremap <silent> <Leader>k :ALEPreviousWrap<CR>

let g:ale_linters = {
            \ 'python'  : ['flake8', 'mypy', 'bandit'],
            \ 'rust'    : ['rustc', 'rls', 'cargo'],
            \ 'haskell' : ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc'],
            \ }

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_rust_rustc_options = ''
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_save = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0

function JavaAbbrs()
    " Java Abbrs
    abbr Sout System.out.println("
    abbr SOut System.out.print("
    abbr fori for(int i = 0, x = .length; i < x; i++)
    abbr psv public static void main(String[] args)
endfunction

function JsAbbrs()
    " Java Abbrs
    abbr fori for(let i = 0, x = .length; i < x; i++)
    abbr clog console.log
endfunction

autocmd FileType java call JavaAbbrs()
autocmd FileType vue call JsAbbrs()
autocmd FileType javascript call JsAbbrs()

" xkcd scroll through time instead of space
"set mouse=a
"nnoremap <ScrollWheelUp> u
"nnoremap <ScrollWheelDown> <C-R>

" Vim-vue settings
autocmd FileType vue syntax sync fromstart
" Only try scss
let g:vue_pre_processors = ['scss', 'typescript']

" settings :: Nvim-R plugin
" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1

let R_in_buffer = 0
let R_applescript = 0
"let R_tmux_split = 1

let R_source = '~/.config/nvim/plugged/nvim-r/R/tmux_split.vim'

" Indentguide settings
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
highlight IndentGuidesOdd  ctermbg=white
highlight IndentGuidesEven ctermbg=blue

highlight IndentGuidesOdd  guibg=#FFFFFF
highlight IndentGuidesEven guibg=#CCCCCC
let g:indent_guides_color_change_percent = 50

" QuickScope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg=#5af78e gui=underline,bold
highlight QuickScopeSecondary guifg=#57c7ff gui=underline,bold

" GitGutter settings
let g:gitgutter_sign_removed = '—'
" Put this in gruvbox.vim to remove signcolumn background
    "call s:HL('GruvboxRedSign', s:red, s:none, s:bold)
    "call s:HL('GruvboxGreenSign', s:green, s:none, s:bold)
    "call s:HL('GruvboxYellowSign', s:yellow, s:none, s:bold)
    "call s:HL('GruvboxBlueSign', s:blue, s:none, s:bold)
    "call s:HL('GruvboxPurpleSign', s:purple, s:none, s:bold)
    "call s:HL('GruvboxAquaSign', s:aqua, s:none, s:bold)
    "call s:HL('GruvboxOrangeSign', s:orange, s:none, s:bold)

" Emmet settings
let g:user_emmet_mode='i'

" NERDCommenter: <Leader> + c<space> = comment, cs = pretty block, cm = multiline
let g:NERDAltDelims_c = 1 " Use // for C

"augroup SyntaxSettings
    "autocmd!
    "autocmd BufNewFile,BufRead *.tsx set filetype=typescript
"augroup END
