------------------------------------------------------------------------------
-- HEADER treesitter
-----------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'latex'}
    },
})
