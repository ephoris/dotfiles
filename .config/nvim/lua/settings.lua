local o = vim.o
local g = vim.g

g.do_filetype_lua = 1

o.mouse = 'a'
o.termguicolors = true

o.number = true
o.cursorline = true
o.cursorlineopt = 'number'

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.hidden = true

o.colorcolumn = '88'
o.textwidth = 88
o.wrap = false
o.list = true
o.linebreak = false

o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.splitright = true
o.splitbelow = true

o.foldcolumn = '0'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

o.showmode = false
o.undofile = true
o.laststatus = 3

o.cmdheight = 0

g.editorconfig = true
