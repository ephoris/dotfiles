---@class util.root
---@overload fun(): string
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.get(...)
  end,
})

---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
  local Util = require("util")
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  
  -- try to find .git or other markers
  local root = vim.fs.root(buf, { ".git", "lua", "package.json" })
  
  -- fallback to cwd
  root = root or vim.uv.cwd()
  
  if opts.normalize then
    return root
  end
  return Util.is_win() and root:gsub("/", "\\") or root
end

function M.git()
  local buf = vim.api.nvim_get_current_buf()
  local root = vim.fs.root(buf, { ".git" })
  return root or M.get()
end

function M.cwd()
  return vim.uv.cwd()
end

function M.info()
  local Util = require("util")
  local root = M.get()
  Util.info({ "Root: `" .. root .. "`" }, { title = "Util Roots" })
end

function M.setup()
  vim.api.nvim_create_user_command("LazyRoot", function()
    M.info()
  end, { desc = "Util roots for the current buffer" })
end

return M
