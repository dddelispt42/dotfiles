-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Codigo do cara
local mux = wezterm.mux
local act = wezterm.action
local size_adjust = 2

config.term = "wezterm"
config.max_fps = 120
-- config.font = wezterm.font 'FiraCode Nerd Font'
config.font = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'VictorMono Nerd Font',
    'JetBrains Mono',
}
config.color_scheme = 'Catppuccin Mocha'

config.font_size = 12.0
config.line_height = 1.1

config.detect_password_input = true
config.window_background_opacity = 0.9

-- config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1126 }

config.keys = {

    { key = 'c', mods = 'LEADER', action = act { SpawnTab = 'CurrentPaneDomain' } },

    { key = '|', mods = 'LEADER', action = act { SplitVertical = { domain = 'CurrentPaneDomain' } } },
    { key = '-', mods = 'LEADER', action = act { SplitHorizontal = { domain = 'CurrentPaneDomain' } } },

    { key = 'h', mods = 'LEADER', action = act { ActivatePaneDirection = 'Left' } },
    { key = 'j', mods = 'LEADER', action = act { ActivatePaneDirection = 'Down' } },
    { key = 'k', mods = 'LEADER', action = act { ActivatePaneDirection = 'Up' } },
    { key = 'l', mods = 'LEADER', action = act { ActivatePaneDirection = 'Right' } },

    { key = 'H', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', size_adjust } },
    { key = 'J', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', size_adjust } },
    { key = 'K', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', size_adjust } },
    { key = 'L', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', size_adjust } },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 's', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },

    { key = '0', mods = 'LEADER', action = act { ActivateTab = 0 } },
    { key = '1', mods = 'LEADER', action = act { ActivateTab = 1 } },
    { key = '2', mods = 'LEADER', action = act { ActivateTab = 2 } },
    { key = '3', mods = 'LEADER', action = act { ActivateTab = 3 } },
    { key = '4', mods = 'LEADER', action = act { ActivateTab = 4 } },
    { key = '5', mods = 'LEADER', action = act { ActivateTab = 5 } },
    { key = '6', mods = 'LEADER', action = act { ActivateTab = 6 } },
    { key = '7', mods = 'LEADER', action = act { ActivateTab = 7 } },
    { key = '8', mods = 'LEADER', action = act { ActivateTab = 8 } },
    { key = '9', mods = 'LEADER', action = act { ActivateTab = 9 } },
    { key = 'x', mods = 'LEADER', action = act { CloseCurrentPane = { confirm = true } } },
    { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },

    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'Tab', mods = 'ALT', action = act.MoveTabRelative(1) },
    { key = 'Tab', mods = 'ALT|SHIFT', action = act.MoveTabRelative(-1) },

    { key = 'c', mods = 'ALT', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
    { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode },
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.window_close_confirmation = 'NeverPrompt'

-- cursor
config.animation_fps = 1
config.audible_bell = "Disabled"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_ease_out = 'Linear'
config.cursor_blink_rate = 600
-- config.default_cursor_style = "BlinkingBlock"
config.default_cursor_style = 'BlinkingBar'
config.enable_scroll_bar = false
config.exit_behavior = "Close"
config.scrollback_lines = 10000
config.window_background_opacity = 0.90

-- WSL
-- config.default_domain = 'WSL:Ubuntu'

return config
