------------------------------------------------------------------------------
-- HEADER which-key
------------------------------------------------------------------------------
vim.o.timeoutlen = 500

local wk = require("which-key")

wk.setup({
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        },
    },
})
