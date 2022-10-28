-----------------------------------------------------------------------------
-- HEADER auto-dark-mode
-----------------------------------------------------------------------------
local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
    set_dark_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        vim.g.gruvbox_material_background = 'medium'
        vim.cmd([[colorscheme gruvbox-material]])
    end,
    set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
        vim.g.everforest_background = 'hard'
        vim.cmd([[colorscheme everforest]])
    end
})
auto_dark_mode.init()


