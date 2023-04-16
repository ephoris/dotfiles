return {
    { "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 7000,
        config = function()
            local cmd = vim.cmd
            local api = vim.api
            require('gruvbox').setup({
                contrast = '',  -- [hard, soft, normal='']
                bold = true,
                italic = {
                    strings = false,
                    comments = false,
                    operators = false,
                    folds = true,
                },
                dim_inactive = false,
            })
            api.nvim_set_option('background', 'dark')
            cmd([[colorscheme gruvbox]])
        end
    },

    { "catppuccin/nvim",
        event = "VeryLazy",
    },

    { "f-person/auto-dark-mode.nvim",
        event = "VeryLazy",
        cond = function()
            return vim.loop.os_uname().sysname == "Darwin"
        end,
        config = function()
            local auto_dark_mode = require('auto-dark-mode')
            auto_dark_mode.setup({
                set_dark_mode = function()
                    vim.api.nvim_set_option('background', 'dark')
                    vim.cmd([[colorscheme gruvbox]])
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option('background', 'light')
                    vim.cmd([[colorscheme catppuccin-latte]])
                end
            })
            auto_dark_mode.init()
        end,
    },
}
