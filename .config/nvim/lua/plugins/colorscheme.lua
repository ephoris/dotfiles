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

    { "sainnhe/everforest",
        event = "VeryLazy"
    },

    { "f-person/auto-dark-mode.nvim",
        cond = function()
            local has = vim.fn.has
            vim.g.is_mac = (
                has("mac")
                or has("macunix")
                or has("gui_macvim")
                or vim.fn.system("uname"):find("darwin") ~= nil)
            return vim.g.is_mac
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
