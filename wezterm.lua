local wezterm = require 'wezterm'
local cfg = wezterm.config_builder()

-- renderer

cfg.front_end = 'OpenGL'

-- window

cfg.window_background_opacity = 0.95
cfg.win32_system_backdrop = 'Acrylic'

cfg.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'

cfg.window_padding = { left = 8, right = 8, top = 8, bottom = 0 }
cfg.window_frame = { border_bottom_height = 6, border_bottom_color = 'rgba(50, 48, 47, 0)' }

cfg.initial_cols = 120
cfg.initial_rows = 30

cfg.window_close_confirmation = 'NeverPrompt'

-- tabs

cfg.tab_bar_at_bottom = true
cfg.use_fancy_tab_bar = false

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = string.format(' %s', tab.tab_index) -- so the window border instead of padding
  return {
    { Text = title },
  }
end)

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
