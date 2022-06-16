------------------------------------------------------------------------------
-- HEADER plugins
------------------------------------------------------------------------------
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

require('config')
