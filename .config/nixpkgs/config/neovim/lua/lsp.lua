--OLD nvim-lspconfig version
-- lspconfig object
local lspconfig = require'nvim_lsp'
local configs = require'nvim_lsp/configs'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({ on_attach=on_attach })

-- Enable hls (Haskell)
--lspconfig.hls.setup({ on_attach=on_attach })

-- Enable python-language-server (Python)
lspconfig.pyls.setup({
    on_attach=on_attach;
    settings = {
        pyls = {
            configurationSources = { "flake8" } -- reads ~/.config/flake8
            }
        }
})

-- Enable vscode language servers (HTML, CSS, JSON)
lspconfig.cssls.setup({ on_attach=on_attach })
lspconfig.html.setup({ on_attach=on_attach })
lspconfig.jsonls.setup({ on_attach=on_attach; cmd={"json-languageserver", "--stdio"} })

-- Enable flow (JavaScript)
lspconfig.flow.setup({ on_attach=on_attach })

-- Enable typescript language server (Typescript)
lspconfig.tsserver.setup({ on_attach=on_attach })

-- Enable bashls (Bash)
lspconfig.bashls.setup({ on_attach=on_attach })

-- Enable vim-language-server (vimscript)
lspconfig.vimls.setup({ on_attach=on_attach })

-- Enable Vue Language Server (Vue.js)
lspconfig.vuels.setup({ on_attach=on_attach })

-- Enable Clangd (C/C++)
lspconfig.clangd.setup({ on_attach=on_attach })

-- Enable lua-language-server (Lua)
lspconfig.sumneko_lua.setup({
    on_attach=on_attach ;
    cmd = { "/bin/lua-language-server", "-E", vim.fn.stdpath('cache').."/lspconfig/sumneko_lua/lua-language-server/main.lua" };
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
})
