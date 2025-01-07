local wezterm = require 'wezterm'
local config = wezterm.config_builder()

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end


function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Gruvbox Dark (Gogh)'
  else
    return 'Catppuccin Latte'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.window_background_opacity = 0.94
config.macos_window_background_blur = 10
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.harfbuzz_features = { 'calt=0' }

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

return config
