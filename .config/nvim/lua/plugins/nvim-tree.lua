return {
    "kyazdani42/nvim-tree.lua",
    config = function()
        require('nvim-tree').setup({
            view = {
                side = 'right',
            },
        })
    end
}
