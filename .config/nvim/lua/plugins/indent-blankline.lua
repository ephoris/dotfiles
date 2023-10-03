return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        vim.o.list = true
        vim.opt.listchars:append('lead:⋅')

        require("ibl").setup()
    end,
}


