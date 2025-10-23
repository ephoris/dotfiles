return
{
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    keys = {
      { "<leader>oM",  "<Cmd>Mason<CR>",  desc = "Open Mason" },
    },
    config = function() require("mason").setup() end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("mason-lspconfig").setup() end
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true
      }
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function() end
  }
}
