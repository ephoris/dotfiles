return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.opt.listchars:append('lead:⋅')
        require("ibl").setup()
    end,
}


