------------------------------------------------------------------------------
-- HEADER plugins
------------------------------------------------------------------------------
local packer_bootstrap = false
local packer_install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
	packer_bootstrap = true
	vim.fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_install_path,
	}
	vim.o.runtimepath = vim.fn.stdpath "data" .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

require('packer').startup(function(use)
    if packer_bootstrap then
		require('packer').sync()
	end
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

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'nvim-telescope/telescope-file-browser.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- LSP Completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- LSP Management & null-ls
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'simrat39/rust-tools.nvim'
    -- Snippets
    use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use 'saadparwaiz1/cmp_luasnip'
    use 'arkav/lualine-lsp-progress'
    use 'ray-x/lsp_signature.nvim'
    use 'kkoomen/vim-doge'


    -- Editor Plugins
    use 'akinsho/toggleterm.nvim'
    use 'windwp/nvim-autopairs'
    use 'machakann/vim-sandwich'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'folke/which-key.nvim'
    use 'folke/zen-mode.nvim'
    use 'folke/twilight.nvim'
    use 'petertriho/nvim-scrollbar'
    use 'kevinhwang91/nvim-hlslens'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- LaTeX
    use 'lervag/vimtex'
end)

require('config')
