return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          disable = { 'latex' }
        },
        folds = {
          enable = true
        }
      })
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    keys = {
      { "<leader>ut", "<cmd>TSContext toggle<cr>", desc = "Toggle Context" },
    }
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
}
