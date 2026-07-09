local Util = require("util")

return {
  {
    "saghen/blink.cmp",
    version = not vim.g.util_blink_main and "*",
    build = vim.g.util_blink_main and "cargo build --release",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies and sources.completion.enabled_providers
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
        version = not vim.g.util_blink_main and "*",
      },
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {},
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, so use your theme instead
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'nerd font mono' or 'normal' for 'nerd font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- create an undo point when accepting a completion item
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      -- signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
      },

      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend("force", { name = source, module = "blink.compat.source" }, opts.sources.providers[source] or {})
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- add ai_accept to <Tab> keymap
      if Util.has("copilot.lua") then
        local copilot = require("copilot.suggestion")
        if opts.keymap["<Tab>"] then
          if type(opts.keymap["<Tab>"]) == "string" then
            opts.keymap["<Tab>"] = { opts.keymap["<Tab>"], "copilot_accept" }
          else
            table.insert(opts.keymap["<Tab>"], "copilot_accept")
          end
        end
        opts.keymap["copilot_accept"] = {
          function()
            if copilot.is_visible() then
              copilot.accept()
              return true
            end
          end,
          "fallback",
        }
      end

      opts.sources.compat = nil

      -- check for older secondary font variant
      if opts.appearance.nerd_font_variant == "mono" then
        opts.appearance.nerd_font_variant = "normal"
      end

      -- remove custom icons from visibility, since blink handles this now
      -- But keep it for now, since it might be useful for some themes
      local icons = require("config.defaults").defaults.icons.kinds
      opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, icons)

      require("blink.cmp").setup(opts)
    end,
  },

  -- lazydev
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- catppuccin support
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { blink_cmp = true },
    },
  },
}
