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
      { "<leader>t",  "<Cmd>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
      { "<leader>T",  "<Cmd>BufferLineCyclePrev<CR>",            desc = "Prev Buffer" },
      { "<leader>x",  "<Cmd>bp|bd#<CR>",                         desc = "Close Buffer" },
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
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    keys = {
      { 'n',  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { 'N',  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
      { '*',  [[*<Cmd>lua require('hlslens').start()<CR>]] },
      { '#',  [[#<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]] },
      { 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]] },
    }
  },

  {
    "petertriho/nvim-scrollbar",
    dependencies = { "kevinhwang91/nvim-hlslens" },
    event = "VeryLazy",
    config = function()
      require('scrollbar').setup()
      require("scrollbar.handlers.search").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location', 'hostname' },
        },
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", function() require("nvim-tree.api").tree.toggle() end, desc = "Nvim Tree" },
      { "<leader>E", function() require("nvim-tree.api").tree.focus() end,  desc = "Nvim Tree" },
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          disable = { 'latex' }
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
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
        map('n', '<leader>gr', gs.reset_hunk, "Reset hunk")
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
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>lx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>lX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>lL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>lQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
  },
}
