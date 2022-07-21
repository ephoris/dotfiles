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
    }
})

require('telescope').load_extension('fzf')
require("telescope").load_extension('file_browser')
