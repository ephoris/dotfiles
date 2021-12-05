local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter'
    use 'romgrk/barbar.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'windwp/nvim-autopairs'
    use 'akinsho/toggleterm.nvim'
    use 'lervag/vimtex'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'arkav/lualine-lsp-progress'
    use "ray-x/lsp_signature.nvim"
    use "folke/which-key.nvim"

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    use {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    }
end)

------------------------------------------------------------------------------
-- HEADER defaults
------------------------------------------------------------------------------
local o = vim.o
local cmd = vim.cmd

o.mouse = 'a'

o.termguicolors = true
o.background = 'dark'
vim.g.gruvbox_contrast_light = 'hard'
vim.g.gruvbox_transparent_bg = 1
cmd([[colorscheme gruvbox]])

o.number = true
cmd([[autocmd ColorScheme * highlight CursorLine gui=NONE cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]])
o.cursorline = true

o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.hidden = true

o.colorcolumn = '120'
o.textwidth = 120
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
key_map('n', '<leader>ff', ':Telescope<CR>', key_opts)
key_map('n', '<leader>n', ':tabnew<CR>', key_opts)
key_map('n', '<leader>s', ':w<CR>', key_opts)
key_map('n', '<leader>fd', ':Telescope lsp_definitions<CR>', key_opts)
key_map('n', '<leader>fr', ':Telescope lsp_references<CR>', key_opts)
key_map('n', '<leader>fb', ':Telescope file_browser<CR>', key_opts)


key_map('n', '<leader>x', ':BufferClose<CR>', key_opts)
key_map('n', '<leader>t', ':BufferNext<CR>', key_opts)
key_map('n', '<leader>T', ':BufferPrevious<CR>', key_opts)

key_map('n', '<leader>b1', ':BufferGoto 1<CR>', key_opts)
key_map('n', '<leader>b2', ':BufferGoto 2<CR>', key_opts)
key_map('n', '<leader>b3', ':BufferGoto 3<CR>', key_opts)
key_map('n', '<leader>b4', ':BufferGoto 4<CR>', key_opts)
key_map('n', '<leader>b5', ':BufferGoto 5<CR>', key_opts)
key_map('n', '<leader>b6', ':BufferGoto 6<CR>', key_opts)
key_map('n', '<leader>b7', ':BufferGoto 7<CR>', key_opts)
key_map('n', '<leader>b8', ':BufferGoto 8<CR>', key_opts)
key_map('n', '<leader>b9', ':BufferGoto 9<CR>', key_opts)
key_map('n', '<leader>b0', ':BufferLast<CR>', key_opts)

key_map('n', '<leader>b<', ':BufferMovePrevious<CR>', key_opts)
key_map('n', '<leader>b>', ':BufferMoveNext<CR>', key_opts)
key_map('n', '<leader>bp', ':BufferPick<CR>', key_opts)
key_map('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', key_opts)
key_map('n', '<leader>bd', ':BufferOrderByDirectory<CR>', key_opts)
key_map('n', '<leader>bl', ':BufferOrderByLanguage<CR>', key_opts)

------------------------------------------------------------------------------
-- HEADER which-key
------------------------------------------------------------------------------
o.timeoutlen = 500

require("which-key").setup({
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 20,
        },
    },
    presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
    },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
    popup_mappings = {
        scroll_down = '<c-d>',
        scroll_up = '<c-u>',
    },
    window = {
        border = "none",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    ignore_missing = false,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true,
    triggers = "auto",
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
})

------------------------------------------------------------------------------
-- HEADER indent-blankline
------------------------------------------------------------------------------
o.list = true
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
-- HEADER telescope
------------------------------------------------------------------------------
require('telescope').setup({
    defaults = {
        mapping = {
            i = {
                ['<C-h>'] = 'which_key'
            }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_made = 'smart_case',
        }
    }
})

require('telescope').load_extension('fzf')

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
-- HEADER nvim-autopairs
------------------------------------------------------------------------------
require('nvim-autopairs').setup({
    disabled_filetypes = {'Telescope-prompt', 'vim'},
})

------------------------------------------------------------------------------
-- HEADER toggleterm
------------------------------------------------------------------------------
require("toggleterm").setup({
    size = 20,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = o.shell,
    float_opts = {
        border = 'curved',
        width = 180,
        height = 90,
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

------------------------------------------------------------------------------
-- HEADER nvim-cmp
------------------------------------------------------------------------------
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.opt.completeopt = 'menu,menuone,noselect'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lsp_symbols = {
    Text = "   (Text) ",
    Method = "   (Method)",
    Function = "   (Function)",
    Constructor = "   (Constructor)",
    Field = " ﴲ  (Field)",
    Variable = "[] (Variable)",
    Class = "   (Class)",
    Interface = " ﰮ  (Interface)",
    Module = "   (Module)",
    Property = " 襁 (Property)",
    Unit = "   (Unit)",
    Value = "   (Value)",
    Enum = " 練 (Enum)",
    Keyword = "   (Keyword)",
    Snippet = "   (Snippet)",
    Color = "   (Color)",
    File = "   (File)",
    Reference = "   (Reference)",
    Folder = "   (Folder)",
    EnumMember = "   (EnumMember)",
    Constant = " ﲀ  (Constant)",
    Struct = " ﳤ  (Struct)",
    Event = "   (Event)",
    Operator = "   (Operator)",
    TypeParameter = "   (TypeParameter)",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, item)
            item.kind = lsp_symbols[item.kind]
            item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
            })[entry.source.name]
            return item
        end,
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

        ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),

        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end
        }),

        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

------------------------------------------------------------------------------
-- HEADER lsp-installer
------------------------------------------------------------------------------
require('nvim-lsp-installer').on_server_ready(function(server)
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        require('lsp_signature').on_attach()
        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end
    opts = {
        on_attach = on_attach,
    }
    server:setup(opts)
end)
