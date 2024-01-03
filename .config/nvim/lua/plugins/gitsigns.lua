return {
    "lewis6991/gitsigns.nvim",
    -- event = "VeryLazy",
    config = function()
        local on_attach = function(_, bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc="Next git chunk"})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true, desc="Prev git chunk"})

            map('n', '<leader>gs', gs.stage_hunk, {desc = "Stage hunk"})
            map('n', '<leader>gr', gs.reset_hunk, {desc = "Reset hunk"})
            map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Stage hunk"})
            map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc = "Reset hunk"})
            map('n', '<leader>gS', gs.stage_buffer, {desc = "Stage buffer"})
            map('n', '<leader>gu', gs.undo_stage_hunk, {desc = "Undo hunk stage"})
            map('n', '<leader>gR', gs.reset_buffer, {desc = "Reset buffer"})
            map('n', '<leader>gp', gs.preview_hunk, {desc = "Preview hunk"})
            map('n', '<leader>gb', function() gs.blame_line{full=true} end, {desc = "Git blame"})
            map('n', '<leader>gtb', gs.toggle_current_line_blame, {desc = "Git toggle blame"})
            map('n', '<leader>gd', gs.diffthis, {desc = "Git diff"})
            map('n', '<leader>gD', function() gs.diffthis('~') end, {desc = "Git diff HEAD"})
            map('n', '<leader>gtd', gs.toggle_deleted, {desc = "Git toggle deleted"})

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = "Select hunk"})
        end
        require("gitsigns").setup({
            on_attach=on_attach
        })
    end,
}
