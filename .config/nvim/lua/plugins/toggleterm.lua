return {
    "akinsho/toggleterm.nvim",
    keys = {
        {"<C-t>", "<cmd>ToggleTerm<CR>", desc="ToggleTerm"}
    },
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<C-t>]],
            direction = 'horizontal',
            shade_terminals = false,
            size = 16,
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
