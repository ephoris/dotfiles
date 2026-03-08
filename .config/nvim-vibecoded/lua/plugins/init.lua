local Util = require("util")

if vim.fn.has("nvim-0.11.2") == 0 then
  vim.api.nvim_echo({
    { "Util requires Neovim >= 0.11.2\n", "ErrorMsg" },
    { "For more info, see: https://github.com/Util/Util/issues/6421\n", "Comment" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

return {
  { "folke/lazy.nvim", version = "*" },
  { import = "plugins.coding" },
  { import = "plugins.colorscheme" },
  { import = "plugins.editor" },
  { import = "plugins.formatting" },
  { import = "plugins.linting" },
  { import = "plugins.lsp" },
  { import = "plugins.treesitter" },
  { import = "plugins.ui" },
  { import = "plugins.util" },
}
