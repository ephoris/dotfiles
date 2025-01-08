return {
    {"nvim-tree/nvim-web-devicons"},

    {
        "stevearc/conform.nvim",
        event = {"BufWritePre"},
        cmd = {"ConformInfo"},
        keys = {
            {"<leader>F",
            function()
                require("conform").format({async = true, lsp_fallback = true})
            end,
            mode = "",
            desc = "Format buffer"}
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = {"ruff", "black"}
                }
            })
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end
    },

    {
        'kdheepak/lazygit.nvim',
        cmd = "LazyGit",
        keys = {
            {"<leader>gl", "<Cmd>LazyGit<CR>", desc = "LazyGit"}
        },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },

    {
        "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        keys = {
            {'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]},
            {'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]},
            {'*', [[*<Cmd>lua require('hlslens').start()<CR>]]},
            {'#', [[#<Cmd>lua require('hlslens').start()<CR>]]},
            {'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Highlight Next"},
            {'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Highlight Prev"},
        }
    },

    {
        "petertriho/nvim-scrollbar",
        dependencies = {"kevinhwang91/nvim-hlslens"},
        event = "VeryLazy",
        config = function()
            require('scrollbar').setup()
            require("scrollbar.handlers.search").setup()
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            require('nvim-autopairs').setup({
                disabled_filetypes = {'Telescope-prompt', 'vim'},
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 20,
                    },
                },
            })
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        keys = {
            {'zR', function() require('ufo').openAllFolds() end, {desc = "Open All Folds"}},
            {'zM', function() require('ufo').closeAllFolds() end, {desc = "Close All Folds"}}
        },
        config = function()
            require('ufo').setup()
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    hide_during_completion = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
            })
        end,
    },
}
