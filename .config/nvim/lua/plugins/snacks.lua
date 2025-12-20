return {
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
}
