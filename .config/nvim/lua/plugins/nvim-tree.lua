return {
    "kyazdani42/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFindFile", "NvimTreeOpen"},
    config = function()
        require('nvim-tree').setup({
            view = {
                side = 'right',
            },
        })
    end
}
