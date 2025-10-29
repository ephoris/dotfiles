-- Looted from https://github.com/Rishabh672003/Neovim/blob/main/lua/rj/lsp.lua

local config = {
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  virtual_text = true,
}
vim.diagnostic.config(config)

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
  capabilities = capabilities,
})
-- }}}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Enable and refresh CodeLens if supported
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    -- client.server_capabilities.semanticTokensProvider = nil

    -- All the keymaps
    -- stylua: ignore start
    local map = vim.keymap.set
    local lsp = vim.lsp
    local opts = { silent = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end
    map("n", "gk", vim.lsp.buf.signature_help, opt("Signature Help"))
    map("n", "<leader>rn", vim.lsp.buf.rename, opt("Rename"))
    map("n", "<leader>ca", vim.lsp.buf.code_action, opt("Code Action"))
    map("n", "<leader>xq", vim.diagnostic.setloclist, opt("Set Local List"))
    map("n", "<leader>ll", vim.diagnostic.open_float, opt("Open diagnostic in float"))
    -- disable the default binding first before using a custom one
    pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
    map("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end, opt("Toggle hover"))
    map("n", "<Leader>lM", vim.cmd.Mason, opt("Mason"))
    map("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
    map("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
    map("n", "<Leader>cl", lsp.codelens.run, opt("Run CodeLens"))
    map("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
    map("n", "[d", function() vim.diagnostic.jump({ count =-1, float = true }) end, opt("Prev Diagnostic"))

  end,
})
-- }}}

