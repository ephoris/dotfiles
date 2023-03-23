return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        {'nvim-lua/plenary.nvim'},
        {'kdheepak/lazygit.nvim'},
        {'nvim-telescope/telescope-file-browser.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
    },
    config = function()
        require('telescope').setup({
            defaults = {
                mapping = {
                    i = {
                        ['<C-h>'] = 'which_key'
                    }
                },
                layout_config = {
                    vertical = {
                        results_height = 0.9,
                        preview_height = 0.6,
                        mirror = true,
                        prompt_position = 'bottom'
                    },
                    width = 0.95,
                    height = 0.95,
                },
                layout_strategy = 'vertical',
            }
        })
        require('telescope').load_extension('fzf')
        require("telescope").load_extension('file_browser')
        require('telescope').load_extension('lazygit')
        vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
    end,
}
