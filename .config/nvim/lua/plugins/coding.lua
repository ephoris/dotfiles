return {
  { -- conform for formatting code
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer"
      }
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff", "ruff_fix", "ruff_organize_imports", "ruff_format" }
        }
      })
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
  },

  { -- nvim-surround for easy nav
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  { -- nvim-autopairs
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require('nvim-autopairs').setup({
        disabled_filetypes = { 'Telescope-prompt', 'vim' },
      })
    end,
  },

  { -- Comment.nvim | Easy auto commenting depending on language
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    keys = {
        {"<leader>cc", "<Cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
    },
    config = function()
      require("claude-code").setup()
    end
  },
}
