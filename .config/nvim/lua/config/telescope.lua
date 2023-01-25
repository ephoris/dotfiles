------------------------------------------------------------------------------
-- HEADER telescope
------------------------------------------------------------------------------
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
                preview_height = 0.75,
                mirror = true,
                prompt_position = 'top'
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
