local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>s', ':w<CR>', { desc = "Write" })
map('n', '<leader>q', ':q<CR>', { desc = "Quit" })
map('n', '<leader>R', ':e<CR>', { desc = "Refresh" })

map('n', '<C-h>', '<C-w>h', { remap = true, desc = "Left Window" })
map('n', '<C-j>', '<C-w>j', { remap = true, desc = "Lower Window" })
map('n', '<C-k>', '<C-w>k', { remap = true, desc = "Upper Window" })
map('n', '<C-l>', '<C-w>l', { remap = true, desc = "Right Window" })

map('t', '<c-,>', '<c-\\><c-n>', { desc = "Normal Mode Terminal" })
