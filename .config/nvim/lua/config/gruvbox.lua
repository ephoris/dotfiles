------------------------------------------------------------------------------
-- HEADER gruvbox
--  Keep settings on color scheme here, sometimes I flop between normal gruvbox
--  and gruvbox-material so we keep both
-----------------------------------------------------------------------------
local cmd = vim.cmd
local g = vim.g
local api = vim.api

require('gruvbox').setup({
    contrast = '',  -- Empty denotes normal contrast, others are hard and soft
    bold = true,
    italic = false,
})
api.nvim_set_option('background', 'dark')
cmd([[colorscheme gruvbox]])
