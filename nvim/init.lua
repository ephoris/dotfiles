local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Display
    use 'f-person/auto-dark-mode.nvim'
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/everforest'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'romgrk/barbar.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    -- LSP
    use 'simrat39/rust-tools.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use 'saadparwaiz1/cmp_luasnip'
    use 'arkav/lualine-lsp-progress'
    use 'ray-x/lsp_signature.nvim'
    use 'kkoomen/vim-doge'

    -- Editing
    use 'akinsho/toggleterm.nvim'
    use 'windwp/nvim-autopairs'
    use 'machakann/vim-sandwich'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'folke/which-key.nvim'
    use 'folke/zen-mode.nvim'
    use 'folke/twilight.nvim'

    -- LaTeX
    use 'lervag/vimtex'
    use 'brymer-meneses/grammar-guard.nvim'
end)

------------------------------------------------------------------------------
-- HEADER defaults
------------------------------------------------------------------------------
local o = vim.o
local cmd = vim.cmd

o.mouse = 'a'

-- color scheme stuff
o.termguicolors = true
vim.g.gruvbox_material_background = 'medium'
cmd([[colorscheme gruvbox-material]])
local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
    set_dark_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        vim.g.gruvbox_material_background = 'medium'
        cmd([[colorscheme gruvbox-material]])
    end,
    set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
        vim.g.everforest_background = 'hard'
        cmd([[colorscheme everforest]])
    end
})
auto_dark_mode.init()


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

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_activate = 1

------------------------------------------------------------------------------
-- HEADER shortcuts
------------------------------------------------------------------------------
local key_opts = {noremap = true, silent = true}
local key_map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
key_map('n', '<leader>e',  ':NvimTreeToggle<CR>', key_opts)
key_map('n', '<leader>s',  ':w<CR>', key_opts)
key_map('n', '<leader>h',  ':nohl<CR>', key_opts)
key_map('n', '<leader>rr', ':e<CR>', key_opts) -- Essentially a refresh

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

key_map('n', '<leader>z', ':ZenMode<CR>', key_opts)

-- Telescope shortcuts
key_map('n', '<leader>ft', ':Telescope<CR>', key_opts)
key_map('n', '<leader>ff', ':Telescope find_files<CR>', key_opts)
key_map('n', '<leader>fr', ':Telescope lsp_references<CR>', key_opts)
key_map('n', '<leader>fd', ':Telescope diagnostics<CR>', key_opts)
key_map('n', '<leader>fb', ':Telescope buffers<CR>', key_opts)
key_map('n', '<leader>fg', ':Telescope live_grep<CR>', key_opts)
key_map('n', '<leader>fz', ':Telescope grep_string<CR>', key_opts)

------------------------------------------------------------------------------
-- HEADER zen-mode
------------------------------------------------------------------------------
require('zen-mode').setup{
    window = {
        backdrop = 0.95,
        width = 128,
        height = 1,
        options = {
          number = true,
          cursorline = true, -- diable cursorline
          cursorlineopt = 'number',
          scrolloff = 99
        }
    }
}

------------------------------------------------------------------------------
-- HEADER which-key
------------------------------------------------------------------------------
o.timeoutlen = 500


local wk = require("which-key")
local show = wk.show
wk.show = function(keys, opts)
    if vim.bo.filetype == "TelescopePrompt" then
        local map = "<c-r>"
        local key = vim.api.nvim_replace_termcodes(map, true, false, true)
        vim.api.nvim_feedkeys(key, "i", true)
    end
    show(keys, opts)
end

wk.setup({
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        },
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
            {'diagnostics', sources={'nvim_diagnostic', 'coc'}}},
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
-----------------------------------------------------------------------------
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
        side = 'left',
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
    open_mapping = [[<C-t>]],
    direction = 'horizontal',
    shade_terminals = false,
    size = 25,
    float_opts = {
        border = 'curved',
        width = 160,
        height = 80,
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

------------------------------------------------------------------------------
-- HEADER lsp-installer nvim-lspconfig
------------------------------------------------------------------------------
require('nvim-lsp-installer').setup({})

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    require('lsp_signature').on_attach()
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>l', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(
	vim.lsp.protocol.make_client_capabilities())

local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
                allFeatures = true,
            },
        }
    }
}

local rust_opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            only_current_line = false,
            show_parameter_hints = true,
            show_variable_name = true,
        }
    },
    server = default_opts
}

require("grammar-guard").init() -- latex server

for _, server in ipairs(require('nvim-lsp-installer').get_installed_servers())
do
    -- if server == 'rust_analyzer' then
    --     -- Never configure with lspconfig
    -- else
    --     require('lspconfig')[server.name].setup(default_opts)
    -- end
    require('lspconfig')[server.name].setup(default_opts)
end
-- TODO: Figure out how to combine
-- Rust tools and nvim-lsp-installer somehow do not play nicely together
-- especially for features like inlay hints
require('rust-tools').setup(rust_opts)


------------------------------------------------------------------------------
-- HEADER nvim-cmp
------------------------------------------------------------------------------
local cmp = require('cmp')
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = 'menu,menuone,noselect'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(
			0, line - 1, line, true)[1]:sub( col, col):match("%s") == nil
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
        ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },
    sources = cmp.config.sources({
        { name = 'nvim_diagnostic' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
