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
          python = { "ruff", "black" }
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

  { -- nvim-ufo | For better folding
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end,  { desc = "Open All Folds" } },
      { 'zM', function() require('ufo').closeAllFolds() end, { desc = "Close All Folds" } }
    },
    config = function()
      require('ufo').setup()
    end,
  },

  { -- colpilot.lua | Testing copilot suggestions
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-l>"
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
}
