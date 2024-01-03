local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "ray-x/lsp_signature.nvim",
        "simrat39/rust-tools.nvim",
    },
}

function M.config()
    require("mason").setup({})
    require("mason-lspconfig").setup({})

    local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }

        require('lsp_signature').on_attach()
        -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc()')
        buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')

        buf_set_keymap('n', 'gD',
            '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd',
            '<cmd>Telescope lsp_definitions<CR>', opts)
        buf_set_keymap('n', 'gr',
            '<cmd>Telescope lsp_references<CR>', opts)
        buf_set_keymap('n', 'gi',
            '<cmd>Telescope lsp_implementations<CR>', opts)
        buf_set_keymap('n', 'gk',
            '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>D',
            '<cmd>Telescope lsp_type_definitions<CR>', opts)
        buf_set_keymap('n', '<leader>rn',
            '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca',
            '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>l',
            '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '<leader>q',
            '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
        buf_set_keymap('n', '<leader>F',
            '<cmd>lua vim.lsp.buf.format({async=True})<CR>', opts)
        buf_set_keymap('n', 'K',
            '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '[d',
            '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d',
            '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    local default_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                },
            },
        },
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
        ['rust_analyzer'] = function ()
            require('rust-tools').setup(rust_opts)
        end,
        function (server_name)
            require('lspconfig')[server_name].setup(default_opts)
        end,
    })
end

return M
