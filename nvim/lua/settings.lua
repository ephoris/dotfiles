------------------------------------------------------------------------------
-- HEADER settings (CLASSIC VIM)
------------------------------------------------------------------------------
local o = vim.o
local cmd = vim.cmd
local g = vim.g
local api = vim.api

o.mouse = 'a'

-- color scheme stuff
o.termguicolors = true
g.gruvbox_material_background = "hard"
cmd([[colorscheme gruvbox-material]])
api.nvim_set_option('background', 'dark')

o.number = true
o.cursorline = true
o.cursorlineopt = 'number'

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.hidden = true

o.colorcolumn = '80'
o.textwidth = 80
o.wrap = false
o.list = true
o.linebreak = true

o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "number"

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 20
