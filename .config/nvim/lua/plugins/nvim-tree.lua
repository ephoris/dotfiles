return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>e",
            function()
                require("nvim-tree.api").tree.toggle()
            end,
            desc = "Nvim Tree"
        },
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}
