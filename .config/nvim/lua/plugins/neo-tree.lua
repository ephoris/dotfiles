return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({toggle = true})
            end,
            desc = "NeoTree",
        },
    },
    config = function()
        require("neo-tree").setup({
            window = {
                position = 'right',
            },
            mappings = {
                ["space"] = "none",
            },
        })
    end
}
