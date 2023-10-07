local wezterm = require 'wezterm'
local cfg = wezterm.config_builder()

-- renderer

cfg.front_end = 'OpenGL'

-- window

cfg.window_background_opacity = 0.95
cfg.win32_system_backdrop = 'Acrylic'

cfg.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
cfg.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

cfg.initial_cols = 120
cfg.initial_rows = 30

cfg.window_close_confirmation = 'NeverPrompt'

-- tabs

cfg.hide_tab_bar_if_only_one_tab = false

-- panes

cfg.inactive_pane_hsb = { brightness = 0.8, saturation = 0.9 }

-- font

cfg.font = wezterm.font {
  family = 'CaskaydiaCove Nerd Font',
  harfbuzz_features = { 'calt = 1', 'ss01 = 1' },
}

cfg.font_size = 13.0

-- colors

cfg.color_scheme = 'Gruvbox Material Dark'

cfg.bold_brightens_ansi_colors = 'No'

-- keys

cfg.leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 5000 }

cfg.keys = {
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

-- shell

cfg.default_prog = { 'pwsh.exe', '-NoLogo' }

-- other

cfg.audible_bell = 'Disabled'

return cfg
