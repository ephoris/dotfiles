local function check()
  print("Checking Util module...")
  local ok_util, util = pcall(require, "util")
  if not ok_util then
    print("ERROR: Util module not found")
    os.exit(1)
  end
  print("Util module OK")

  print("Checking Snacks...")
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    print("ERROR: snacks.nvim not found in RTP")
  else
    print("snacks.nvim module found")
  end

  print("Checking colorscheme...")
  local ok_color = pcall(vim.cmd.colorscheme, "tokyonight")
  if not ok_color then
    print("WARNING: tokyonight not found (might not be installed yet)")
  else
    print("tokyonight colorscheme OK")
  end

  print("Config check finished successfully")
end

check()
