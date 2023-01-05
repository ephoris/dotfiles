------------------------------------------------------------------------------
-- HEADER lsp-installer nvim-lspconfig
------------------------------------------------------------------------------
require("mason").setup {}
require("mason-lspconfig").setup {}

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap = true, silent = true }

    require('lsp_signature').on_attach()
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>l', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.format({async=True})<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                allFeatures = true,
            },
        }
    }
}

local rust_opts = {
    tools = {
        autoSetHints = true,
        inlay_hints = {
            only_current_line = false,
            show_parameter_hints = true,
            show_variable_name = true,
        }
    },
    server = default_opts
}

require('mason-lspconfig').setup_handlers({
    function (server_name)
        require('lspconfig')[server_name].setup(default_opts)
    end,
    ['rust_analyzer'] = function ()
        require('rust-tools').setup(rust_opts)
    end,
    ["sumneko_lua"] = function ()
        require('lspconfig').sumneko_lua.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.formatting.autopep8,
    },
})
