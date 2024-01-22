return {
    "nvim-treesitter/nvim-treesitter",
    version = "0.9.*",
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                disable = {'latex'}
            },
        })
    end,
}
