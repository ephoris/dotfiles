return {
    { "kyazdani42/nvim-web-devicons" },
    { "machakann/vim-sandwich" },
    { "romgrk/barbar.nvim" },

    { "petertriho/nvim-scrollbar",
        dependencies = {"kevinhwang91/nvim-hlslens"},
        config = function()
            require('scrollbar').setup()
            require("scrollbar.handlers.search").setup()
        end,
    },

    { "windwp/nvim-autopairs",
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

    { "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
}
