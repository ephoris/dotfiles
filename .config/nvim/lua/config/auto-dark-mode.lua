-----------------------------------------------------------------------------
-- HEADER auto-dark-mode
-----------------------------------------------------------------------------
local has = vim.fn.has
vim.g.is_mac = (has("mac")
    or has("macunix")
    or has("gui_macvim")
    or vim.fn.system("uname"):find("darwin") ~= nil)

if(vim.g.is_mac)
then
    local auto_dark_mode = require('auto-dark-mode')
    auto_dark_mode.setup({
        set_dark_mode = function()
            vim.api.nvim_set_option('background', 'dark')
            vim.cmd([[colorscheme gruvbox]])
        end,
        set_light_mode = function()
            vim.api.nvim_set_option('background', 'light')
            vim.g.everforest_background = 'hard'
            vim.cmd([[colorscheme everforest]])
        end
    })
    auto_dark_mode.init()
end
