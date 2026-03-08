-- Show context of the current function
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  opts = { mode = "cursor", max_lines = 3 },
  config = function(_, opts)
    require("treesitter-context").setup(opts)
    Snacks.toggle({
      name = "Treesitter Context",
      get = function()
        return require("treesitter-context").enabled()
      end,
      set = function(state)
        if state then
          require("treesitter-context").enable()
        else
          require("treesitter-context").disable()
        end
      end,
    }):map("<leader>ut")
  end,
}
