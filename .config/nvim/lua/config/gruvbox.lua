------------------------------------------------------------------------------
-- HEADER gruvbox
--  Keep settings on color scheme here, sometimes I flop between normal gruvbox
--  and gruvbox-material so we keep both
-----------------------------------------------------------------------------
local cmd = vim.cmd
local api = vim.api

require('gruvbox').setup({
    contrast = '',  -- Empty denotes normal contrast, others are hard and soft
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
