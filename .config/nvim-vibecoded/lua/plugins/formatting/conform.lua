local Util = require("util")

return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "x" },
        desc = "Format Injected Langs",
      },
      {
        "<leader>cf",
        function()
          require("conform").format({ bufnr = 0 })
        end,
        mode = { "n", "x" },
        desc = "Format",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Autoformat autocmd
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformAutoformat", {}),
        callback = function(event)
          if vim.g.autoformat == false or vim.b[event.buf].autoformat == false then
            return
          end
          require("conform").format({ bufnr = event.buf })
        end,
      })

      -- Manual format command
      vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ bufnr = 0 })
      end, { desc = "Format buffer" })

      -- Toggles
      Snacks.toggle({
        name = "Auto Format (Global)",
        get = function()
          return vim.g.autoformat ~= false
        end,
        set = function(state)
          vim.g.autoformat = state
          Util.info((state and "Enabled" or "Disabled") .. " auto format (global)")
        end,
      }):map("<leader>uf")

      Snacks.toggle({
        name = "Auto Format (Buffer)",
        get = function()
          return vim.b.autoformat ~= false
        end,
        set = function(state)
          vim.b.autoformat = state
          Util.info((state and "Enabled" or "Disabled") .. " auto format (buffer)")
        end,
      }):map("<leader>uF")
    end,
  },
}
