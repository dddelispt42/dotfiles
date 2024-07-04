-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.font = wezterm.font 'FiraCode Nerd Font'
config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font',
  'JetBrains Mono',
}
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 1.0

return config
