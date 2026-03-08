local Util = require("util")

return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    ---@class util.TSConfig: TSConfig
    opts = {
      -- Util config for treesitter
      indent = { enable = true },
      highlight = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    ---@param opts util.TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = Util.dedup(opts.ensure_installed)
      end

      -- Support both the old and new nvim-treesitter API
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
      end

      -- Explicitly enable TS highlighting for new TS versions where configs.setup is gone
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        callback = function(args)
          local buf = args.buf
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end
          -- Skip special buffers
          if vim.bo[buf].buftype ~= "" then
            return
          end
          local ok_ts, _ = pcall(vim.treesitter.get_parser, buf)
          if ok_ts then
            -- Enable highlighting
            vim.treesitter.start(buf)
            -- Use treesitter for folding and indents
            Util.set_opt("foldmethod", "expr", buf)
            Util.set_opt("foldexpr", "v:lua.vim.treesitter.foldexpr()", buf)
          end
        end,
      })
    end,
  },
}
