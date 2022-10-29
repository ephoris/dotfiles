------------------------------------------------------------------------------
-- HEADER which-key
------------------------------------------------------------------------------
vim.o.timeoutlen = 500

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
