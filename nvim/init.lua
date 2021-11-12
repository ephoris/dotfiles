local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    }

    use 'nvim-treesitter/nvim-treesitter'
    use 'romgrk/barbar.nvim'
    use 'kyazdani42/nvim-tree.lua'

    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-lualine/lualine.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'L3MON4D3/LuaSnip'
    use 'arkav/lualine-lsp-progress'
end)

local o = vim.o
local cmd = vim.cmd

o.mouse = 'a'

o.termguicolors = true
o.background = 'dark'
cmd([[colorscheme gruvbox]])

o.number = true
cmd([[autocmd ColorScheme * highlight CursorLine gui=NONE cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]])
o.cursorline = true

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true

o.colorcolumn = '80'
o.textwidth = 80
o.wrap = false
o.list = true
o.linebreak = true

o.hlsearch = true
o.ignorecase = true
o.smartcase = true

------------------------------------------------------------------------------
-- HEADER shortcuts
------------------------------------------------------------------------------
local key_opts = {noremap = true, silent = true}
local key_map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
key_map('n', '<leader>e', ':NvimTreeToggle<CR>', key_opts)

------------------------------------------------------------------------------
-- HEADER indent-blankline
------------------------------------------------------------------------------
vim.o.list = true
vim.opt.listchars:append('lead:⋅')

require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
})

------------------------------------------------------------------------------
-- HEADER lualine
------------------------------------------------------------------------------

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff',
                      {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        lualine_c = {'filename', 'lsp_progress'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})

------------------------------------------------------------------------------
-- HEADER treesitter
------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
})

------------------------------------------------------------------------------
-- HEADER nvim-tree
------------------------------------------------------------------------------
require('nvim-tree').setup({
    view = {
        side = 'right',
    },
})

------------------------------------------------------------------------------
-- HEADER lsp
------------------------------------------------------------------------------

require('nvim-lsp-installer').on_server_ready(function(server)
    opts = {}
    server:setup(opts)
end)

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.ls_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    })
})
