local M = {
    "neovim/nvim-lspconfig",
    opts = {
        inlay_hints = {
            enabled = true
        }
    },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "ray-x/lsp_signature.nvim",
    },
}

function M.config()
    local on_attach = function(client, bufnr)
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint(bufnr, true)
        else
            print("Inlay hints unavailable")
        end

        require('lsp_signature').on_attach()
        buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')

        map("n", "gD", function() vim.lsp.buf.declaration() end, {desc = "Goto Declaration"})
        map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, {desc = "Goto Definition"})
        map("n", "gr", function() require("telescope.builtin").lsp_references() end, {desc = "Goto Reference"})
        map("n", "gi", function() require("telescope.builtin").lsp_implementations() end, {desc = "Goto Implementation"})
        map("n", "gk", function() vim.lsp.buf.signature_help() end, {desc = "Signature Help"})
        map("n", "<leader>D", function() require("telescope.builtin").lsp_type_definitions() end, {desc = "Goto Type Definition"})
        map("n", "<leader>rn", function() vim.lsp.buf.rename() end, {desc = "Rename"})
        map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, {desc = "Code Action"})
        map("n", "<leader>l", function() vim.diagnostic.open_float() end, {desc = "Open Diagnostic"})
        map("n", "<leader>q", function() vim.diagnostic.setloclist() end, {desc = "Set Local List"})
        map("n", "<leader>F", function() vim.lsp.buf.format({async=True}) end, {desc = "Format File"})
        map("n", "K", function() vim.lsp.buf.hover() end, {desc = "Hover"})
        map("n", "[d", function() vim.diagnostic.goto_prev() end, {desc = "Prev Diagnostic"})
        map("n", "]d", function() vim.diagnostic.goto_next() end, {desc = "Next Diagnostic"})
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

    require("mason").setup()
    require("mason-lspconfig").setup()
    require('mason-nvim-dap').setup()
    require('mason-lspconfig').setup_handlers({
        function (server_name)
            require('lspconfig')[server_name].setup(default_opts)
        end,
    })
end

return M
