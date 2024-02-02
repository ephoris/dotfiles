local M = {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('bufferline').setup()
    end,
    keys = {
        {"<leader>t", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer"},
        {"<leader>T", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer"},
        {"<leader>x", "<Cmd>bp|bd#<CR>", desc = "Close Buffer"},
        { "<leader>b>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Next Buffer" },
        { "<leader>b<", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Prev Buffer" },
        { "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Buffer Pick" },
        { "<leader>bb", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
        { "<leader>bB", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    },
}

return M
