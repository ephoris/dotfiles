return {
    { "kyazdani42/nvim-web-devicons",
        event = "VeryLazy",
    },

    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    { "romgrk/barbar.nvim",
        event = "VeryLazy",
    },

    { "petertriho/nvim-scrollbar",
        dependencies = {"kevinhwang91/nvim-hlslens"},
        event = "VeryLazy",
        config = function()
            require('scrollbar').setup()
            require("scrollbar.handlers.search").setup()
        end,
    },

    { "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            require('nvim-autopairs').setup({
                disabled_filetypes = {'Telescope-prompt', 'vim'},
            })
        end,
    },

    { "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    { "folke/which-key.nvim",
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

    { "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require('ufo').setup()
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        end,
    },
}
