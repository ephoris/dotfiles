local Util = require("util")

return {
  -- Configures LuaLS to support auto-completion and type checking
  -- while editing your Neovim configuration.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "Util", words = { "Util" } },
        { path = "folke/snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "Util" } },
      },
    },
  },
}
