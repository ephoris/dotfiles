local LazyUtil = require("lazy.core.util")

---@class util: LazyUtilCore
---@field config UtilConfig
---@field lsp util.lsp
---@field root util.root
---@field terminal util.terminal
---@field mini util.mini
local M = {}

_G.Util = M

-- Explicitly load sub-modules
M.lsp = require("util.lsp")
M.mini = require("util.mini")
M.root = require("util.root")

-- Delegate to LazyUtil for core helpers
setmetatable(M, {
  __index = function(_, k)
    return LazyUtil[k]
  end,
})

---@class util.terminal
M.terminal = {}

---@param shell? string
function M.terminal.setup(shell)
  vim.o.shell = shell or vim.o.shell

  -- Special handling for pwsh
  if shell == "pwsh" or shell == "powershell" then
    -- Check if 'pwsh' is executable and set the shell accordingly
    if vim.fn.executable("pwsh") == 1 then
      vim.o.shell = "pwsh"
    elseif vim.fn.executable("powershell") == 1 then
      vim.o.shell = "powershell"
    else
      return Util.error("No powershell executable found")
    end

    -- Setting shell command flags
    vim.o.shellcmdflag =
      "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"

    -- Setting shell redirection
    vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

    -- Setting shell pipe
    vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

    -- Setting shell quote options
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
  end
end

---@class util.treesitter
M.treesitter = {}

---@param buf? number
---@return boolean
function M.treesitter.have(buf)
  local ok, parser = pcall(vim.treesitter.get_parser, buf or 0)
  return ok and parser ~= nil
end

function M.is_win()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
  local plugin = M.get_plugin(name)
  path = path and "/" .. path or ""
  return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.uv.new_timer()
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
  end
end

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
function M.get_pkg_path(pkg, path, opts)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ""
  local ret = vim.fs.normalize(root .. "/packages/" .. pkg .. "/" .. path)
  if opts.warn then
    vim.schedule(function()
      if not require("lazy.core.config").headless() and not vim.loop.fs_stat(ret) then
        M.warn(
          ("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(
            pkg,
            path
          )
        )
      end
    end)
  end
  return ret
end

--- Override the default title for notifications.
for _, level in ipairs({ "info", "warn", "error" }) do
  M[level] = function(msg, opts)
    opts = opts or {}
    opts.title = opts.title or "Util"
    return LazyUtil[level](msg, opts)
  end
end

-- Safe wrapper around snacks to prevent errors when Util is still installing
function M.statuscolumn()
  return package.loaded.snacks and require("snacks.statuscolumn").get() or ""
end

---@param option string
---@param value string|number|boolean
---@param buf? number
function M.set_opt(option, value, buf)
  if buf then
    local ok = pcall(vim.api.nvim_set_option_value, option, value, { scope = "local", buf = buf })
    if not ok then
      for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_set_option_value(option, value, { scope = "local", win = win })
      end
    end
  else
    vim.api.nvim_set_option_value(option, value, { scope = "local" })
  end
end

---@param fn fun()
---@return any
function M.try(fn, opts)
  opts = type(opts) == "string" and { msg = opts } or opts or {}
  local ok, result = pcall(fn)
  if not ok then
    local msg = opts.msg or ""
    M.error({ msg, result })
  end
  return result
end

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")
M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

return M
