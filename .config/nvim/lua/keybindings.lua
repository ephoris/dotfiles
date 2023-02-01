------------------------------------------------------------------------------
-- HEADER keybindings
------------------------------------------------------------------------------
local key_opts = {noremap = true, silent = true}
local key_map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

key_map('n', '<leader>e',  ':NvimTreeToggle<CR>', key_opts)
key_map('n', '<leader>s',  ':w<CR>', key_opts)
key_map('n', '<leader>h',  ':nohl<CR>', key_opts)
key_map('n', '<leader>rr', ':e<CR>', key_opts) -- Essentially a refresh

key_map('n', '<leader>x', ':BufferClose<CR>', key_opts)
key_map('n', '<leader>t', ':BufferNext<CR>', key_opts)
key_map('n', '<leader>T', ':BufferPrevious<CR>', key_opts)

key_map('n', '<leader>b1', ':BufferGoto 1<CR>', key_opts)
key_map('n', '<leader>b2', ':BufferGoto 2<CR>', key_opts)
key_map('n', '<leader>b3', ':BufferGoto 3<CR>', key_opts)
key_map('n', '<leader>b4', ':BufferGoto 4<CR>', key_opts)
key_map('n', '<leader>b5', ':BufferGoto 5<CR>', key_opts)
key_map('n', '<leader>b6', ':BufferGoto 6<CR>', key_opts)
key_map('n', '<leader>b7', ':BufferGoto 7<CR>', key_opts)
key_map('n', '<leader>b8', ':BufferGoto 8<CR>', key_opts)
key_map('n', '<leader>b9', ':BufferGoto 9<CR>', key_opts)
key_map('n', '<leader>b0', ':BufferLast<CR>', key_opts)

key_map('n', '<leader>b<', ':BufferMovePrevious<CR>', key_opts)
key_map('n', '<leader>b>', ':BufferMoveNext<CR>', key_opts)
key_map('n', '<leader>bp', ':BufferPick<CR>', key_opts)
key_map('n', '<leader>bb', ':BufferOrderByBufferNumber<CR>', key_opts)
key_map('n', '<leader>bd', ':BufferOrderByDirectory<CR>', key_opts)
key_map('n', '<leader>bl', ':BufferOrderByLanguage<CR>', key_opts)

key_map('n', '<leader>z', ':ZenMode<CR>', key_opts)

-- Telescope shortcuts
key_map('n', '<leader>ft', ':Telescope<CR>', key_opts)
key_map('n', '<leader>ff', ':Telescope find_files<CR>', key_opts)
key_map('n', '<leader>fr', ':Telescope lsp_references<CR>', key_opts)
key_map('n', '<leader>fd', ':Telescope diagnostics<CR>', key_opts)
key_map('n', '<leader>fb', ':Telescope buffers<CR>', key_opts)
key_map('n', '<leader>fg', ':Telescope live_grep<CR>', key_opts)
key_map('n', '<leader>fz', ':Telescope current_buffer_fuzzy_find<CR>', key_opts)
key_map('n', '<leader>fs', ':Telescope grep_string<CR>', key_opts)
key_map('n', '<leader>fv', ':Telescope lsp_document_symbols<CR>', key_opts)
key_map('n', '<leader>fe', ':Telescope file_browser<CR>', key_opts)
key_map('n', '<leader>fh', ':Telescope help_tags<CR>', key_opts)
key_map('n', '<leader>fl', ':lua require("telescope").extensions.lazygit.lazygit()', key_opts)

key_map('n', '<leader>gl', ':LazyGit<CR>', key_opts)

key_map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], key_opts)
key_map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], key_opts)
key_map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], key_opts)
key_map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], key_opts)
key_map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], key_opts)
key_map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], key_opts)

key_map('n', '<C-h>', '<C-w>h', key_opts)
key_map('n', '<C-j>', '<C-w>j', key_opts)
key_map('n', '<C-k>', '<C-w>k', key_opts)
key_map('n', '<C-l>', '<C-w>l', key_opts)

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
