------------------------------------------------------------------------------
-- HEADER toggleterm
------------------------------------------------------------------------------
return {
    "akinsho/toggleterm.nvim",
    config = function()
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
    end,
}
