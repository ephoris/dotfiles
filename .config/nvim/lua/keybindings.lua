local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>s', ':w<CR>', { desc = "Write" })
map('n', '<leader>h', ':nohl<CR>', { desc = "Toggle Highlight" })
map('n', '<leader>rr', ':e<CR>', { desc = "Refresh" })

map('n', '<C-h>', '<C-w>h', { remap = true, desc = "Left Window" })
map('n', '<C-j>', '<C-w>j', { remap = true, desc = "Lower Window" })
map('n', '<C-k>', '<C-w>k', { remap = true, desc = "Upper Window" })
map('n', '<C-l>', '<C-w>l', { remap = true, desc = "Right Window" })

map('t', '<c-,>', '<c-\\><c-n>', { desc = "Normal Mode Terminal" })

-- -- LSP Specific
-- map("n", "gk", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
-- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
-- map("n", "<leader>ll", function() vim.diagnostic.open_float() end, { desc = "Open Diagnostic" })
-- map("n", "<leader>q", function() vim.diagnostic.setloclist() end, { desc = "Set Local List" })
-- map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
-- map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })
-- map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
