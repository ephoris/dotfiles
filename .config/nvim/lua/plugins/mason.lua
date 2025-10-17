return
{
  {
    "williamboman/mason.nvim",
    cmd = {"Mason"},
    keys = {
      { "<leader>M",  "<Cmd>Mason<CR>",  desc = "Mason" },
    },
    config = function() require("mason").setup() end
  },

  {
    "williamboman/mason-lspconfig.nvim",
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
