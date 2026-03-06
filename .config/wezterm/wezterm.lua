local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Mocha'
  else
    return 'Catppuccin Latte'
  end
end

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  -- Linkify things that look like URLs and the host has a TLD name.
  -- Compiled-in default. Used if you don't specify any hyperlink_rules.
  regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
  format = "$0",
})
table.insert(config.hyperlink_rules, {
  -- linkify email addresses
  -- Compiled-in default. Used if you don't specify any hyperlink_rules.
  regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
  format = "mailto:$0",
})
table.insert(config.hyperlink_rules, {
  -- file:// URI
  -- Compiled-in default. Used if you don't specify any hyperlink_rules.
  regex = [[\bfile://\S*\b]],
  format = "$0",
})
table.insert(config.hyperlink_rules, {
  -- Linkify things that look like URLs with numeric addresses as hosts.
  -- E.g. http://127.0.0.1:8000 for a local development server,
  -- or http://192.168.1.1 for the web interface of many routers.
  regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
  format = "$0",
})

config.bold_brightens_ansi_colors = true
config.color_scheme = scheme_for_appearance(get_appearance())
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBlock"
config.enable_kitty_graphics = true
config.font_size = 15
config.harfbuzz_features = { 'calt=0' }
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 10
config.max_fps = 120
config.scrollback_lines = 10000
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.94
-- config.window_content_alignment = { horizontal = 'Left', vertical = 'Center' }
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.keys = {
  { key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"} },
}
config.window_decorations = "RESIZE"

return config
