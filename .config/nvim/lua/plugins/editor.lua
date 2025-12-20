return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('bufferline').setup()
    end,
    keys = {
      { "<leader>b>", "<Cmd>BufferLineMoveNext<CR>",             desc = "Move Next Buffer" },
      { "<leader>b<", "<Cmd>BufferLineMovePrev<CR>",             desc = "Move Prev Buffer" },
      { "<leader>bp", "<Cmd>BufferLinePick<CR>",                 desc = "Buffer Pick" },
      { "<leader>bb", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bB", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter'}, -- if you use the mini.nvim suite
    event = { "BufEnter *.md" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, "Next git chunk")

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, "Prev git chunk")

        map('n', '<leader>gs', gs.stage_hunk, "Stage hunk")
        map('n', '<leader>gr', gs.reset_hunk, "Reset hun")
        map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk")
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset hunk")
        map('n', '<leader>gS', gs.stage_buffer, "Stage buffer")
        map('n', '<leader>gu', gs.undo_stage_hunk, "Undo hunk stage")
        map('n', '<leader>gR', gs.reset_buffer, "Reset buffer")
        map('n', '<leader>gp', gs.preview_hunk, "Preview hunk")
        map('n', '<leader>gb', function() gs.blame_line { full = true } end, "Git blame")
        map('n', '<leader>gtb', gs.toggle_current_line_blame, "Git toggle blame")
        map('n', '<leader>gd', gs.diffthis, "Git diff")
        map('n', '<leader>gD', function() gs.diffthis('~') end, "Git diff HEAD")
        map('n', '<leader>gtd', gs.toggle_deleted, "Git toggle deleted")

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select hunk")
      end,
    },
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufFilePre", "BufNewFile" },
    keys = {
      { 'n',  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc="Next Highlight" },
      { 'N',  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc="Prev Highlight" },
      { '*',  [[*<Cmd>lua require('hlslens').start()<CR>]], desc="Search Next" },
      { '#',  [[#<Cmd>lua require('hlslens').start()<CR>]], desc="Search Prev" },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], desc="Search Next" },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], desc="Search Prev" },
    }
  },

  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require('scrollbar').setup()
      require("scrollbar.handlers.search").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      delay = 64,
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "diagnostics" },
          { "<leader>o", group = "open" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },

}
