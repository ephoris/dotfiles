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

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
            { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } },
            {
              'macro',
              fmt = function()
                local reg = vim.fn.reg_recording()
                if reg ~= "" then
                  return "Recording @" .. reg
                end
                return nil
              end,
              color = { fg = "#ff9e64" },
              draw_empty = false,
            }
          },
          lualine_c = { 'filename' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location', 'hostname' },
        },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 0, padding = 1},
          { icon = " ", title = "Recent Files", section = "recent_files", padding = 1},
          { icon = " ", title = "Projects", section = "projects", padding = 1},
          { section = "startup" },
        },
      },
      explorer = { enabled = true },
      indent = { enabled = true, animate = { enabled = true } },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        layout = {
          preset = function()
            return vim.o.columns >= 120 and 'default' or 'vertical'
          end,
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              min_width = 120,
              width = 0.9,
              height = 0.9,
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
            },
          },
          vertical = {
            layout = {
              backdrop = true,
              width = 0.9,
              height = 0.9,
              min_height = 30,
              box = "vertical",
              border = true,
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.6, border = "top" },
            },
          },
        },
      },
      quickfile = { enabled = true },
      terminal = { enabled = true },
    },
    keys = function()
      return {
        { "<leader>oc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Open Config" },
        { "<leader>ol", function() Snacks.lazy() end,                        desc = "Lazy" },
        { "<leader>e",  function() Snacks.explorer() end,                    desc = "Explorer" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end,         desc = "Colorscheme with Preview" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end,              desc = "Buffers" },
        { "<leader>ff", function() Snacks.picker.files() end,                desc = "Find Files" },
        { "<leader>fr", function() Snacks.picker.recent() end,               desc = "Recent" },
        { "<leader>fW", function() Snacks.picker.registers() end,            desc = "Registers" },
        { "<leader>fh", function() Snacks.picker.help() end,                 desc = "Help Pages" },
        { "<leader>fc", function() Snacks.picker.command_history() end,      desc = "Command History" },
        { "<leader>fC", function() Snacks.picker.commands() end,             desc = "Commands" },
        { "<leader>fk", function() Snacks.picker.keymaps() end,              desc = "Keymaps" },
        { "<leader>fq", function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
        { '<leader>f"', function() Snacks.picker.registers() end,            desc = "Registers" },
        -- find via grep
        { "<leader>fl", function() Snacks.picker.lines() end,                desc = "Buffer Lines" },
        { "<leader>fB", function() Snacks.picker.grep_buffers() end,         desc = "Grep Open Buffers" },
        { "<leader>fg", function() Snacks.picker.grep() end,                 desc = "Grep" },
        { "<leader>fw", function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>/",  function() Snacks.picker.grep() end,                 desc = "Grep" },
        -- git
        { "<leader>gc", function() Snacks.picker.git_log() end,              desc = "Git Log" },
        { "<leader>gl", function() Snacks.lazygit() end,                     desc = "Lazygit" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declarations" },
        { "gr",         function() Snacks.picker.lsp_references() end,       desc = "References", nowait = true},
        { "gi",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "gai",        function() Snacks.picker.lsp_incoming_calls() end,   desc = "C[a]lls Incoming" },
        { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,   desc = "C[a]lls Outgoing" },
        { "<leader>fs", function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },
        { "<leader>fd", function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
        { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end,   desc = "Buffer Diagnostics" },
        -- misc
        { "<leader>fM", function() Snacks.picker.man() end,                  desc = "Man" },
        { "<leader>fu", function() Snacks.picker.undo() end,                 desc = "Undo History" },
        -- notifications
        { "<leader>f]", function() Snacks.notifier.show_history() end,       desc = "Notifier History" },
        { "<leader>un", function() Snacks.notifier.hide() end,               desc = "Dismiss All Notifications" },
        { "<c-,>",      function() Snacks.terminal() end,                    desc = "Toggle Terminal" },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uH")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
          Snacks.toggle.animate():map("<leader>ua")
          Snacks.toggle({
            name = "Virtual Text",
            get = function() return vim.diagnostic.config().virtual_text ~= false end,
            set = function(state) vim.diagnostic.config({ virtual_text = state }) end,
          }):map("<leader>uv")
        end,
      })
    end,
  },
}
