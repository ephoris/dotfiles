return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        background = {
            light = "latte",
            dark = "macchiato",
        },
        transparent_background = true,
      })
      vim.api.nvim_set_option('background', 'dark')
      vim.cmd [[colorscheme catppuccin]]
    end
  },

  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    cond = function()
      return vim.loop.os_uname().sysname == "Darwin"
    end,
    config = function()
      local auto_dark_mode = require('auto-dark-mode')
      auto_dark_mode.setup({
        set_dark_mode = function()
          vim.api.nvim_set_option('background', 'dark')
          vim.cmd [[colorscheme catppuccin-macchiato]]
        end,
        set_light_mode = function()
          vim.api.nvim_set_option('background', 'light')
          vim.cmd [[colorscheme catppuccin-latte]]
        end
      })
      auto_dark_mode.init()
    end,
  },
}
