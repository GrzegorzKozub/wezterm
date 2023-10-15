local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local colors = wezterm.color.load_scheme(wezterm.config_dir .. '/colors/gruvbox-material-dark.toml')

-- renderer

config.front_end = 'OpenGL'

-- window

config.window_background_opacity = 0.95
config.win32_system_backdrop = 'Acrylic'

config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'

config.window_padding = { left = 16, right = 16, top = 16, bottom = 0 }
config.window_frame = {
  font = wezterm.font 'Segoe UI',
  border_bottom_height = 12,
  border_bottom_color = 'rgba(50, 48, 47, 0)',
}

config.initial_cols = 120
config.initial_rows = 30

config.window_close_confirmation = 'NeverPrompt'

-- tabs

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.show_new_tab_button_in_tab_bar = false

local plus = '󰐕'
local close = '󰖭 '
local hide = '󰖰  '
local maximize = '󰖯  '

config.tab_bar_style = {
  new_tab = wezterm.format {
    { Text = plus },
  },
  new_tab_hover = wezterm.format {
    { Text = plus },
  },
  window_close = wezterm.format {
    { Text = close },
  },
  window_close_hover = wezterm.format {
    { Foreground = { Color = colors.ansi[2] } },

    { Text = close },
  },
  window_hide = wezterm.format {
    { Text = hide },
  },
  window_hide_hover = wezterm.format {
    { Text = hide },
  },
  window_maximize = wezterm.format {
    { Text = maximize },
  },
  window_maximize_hover = wezterm.format {
    { Text = maximize },
  },
}

-- panes

config.inactive_pane_hsb = { brightness = 0.8, saturation = 0.9 }

-- font

config.font = wezterm.font {
  family = 'CaskaydiaCove Nerd Font',
  harfbuzz_features = { 'calt = 1', 'ss01 = 1' },
}

config.font_size = 13.0
config.command_palette_font_size = 13.0
config.char_select_font_size = 13.0

-- colors

config.color_scheme = 'Gruvbox Material Dark'

config.bold_brightens_ansi_colors = 'No'

config.command_palette_bg_color = colors.cursor_fg
config.command_palette_fg_color = colors.foreground

config.char_select_bg_color = colors.cursor_fg
config.char_select_fg_color = colors.foreground

config.colors = {
  copy_mode_active_highlight_bg = { Color = colors.ansi[4] },
  copy_mode_active_highlight_fg = { Color = colors.background },
  copy_mode_inactive_highlight_bg = { Color = colors.brights[4] },
  copy_mode_inactive_highlight_fg = { Color = colors.background },

  quick_select_label_bg = { Color = colors.ansi[4] },
  quick_select_label_fg = { Color = colors.background },
  quick_select_match_bg = { Color = colors.brights[4] },
  quick_select_match_fg = { Color = colors.background },
}

-- keys

  local copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(
    copy_mode,
    
{


        key = 'q',
        mods = 'CTRL',
        action = wezterm.action.CopyMode { SetSelectionMode = 'Block' },
      }

  )

config.leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 5000 }

config.keys = {


  {
    key = 'f',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.Search { CaseInSensitiveString = '' },
  },

 {
    key = '{',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },

 {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  },




  {
    key = 'PageUp',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByPage(-1),
  },





  {
    key = 'PageDown',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByPage(1),
  },

  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(-1),
  },

  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(1),
  },

  {
    key = 'Home',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollToTop,
  },

  {
    key = 'End',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollToBottom,
  },

  {
    key = 'F1',
    action = wezterm.action.ActivateCommandPalette,
  },
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
  {
    key = 'h',
    mods = 'ALT|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'v',
    mods = 'ALT|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'z',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },

  -- tmux
  {
    key = 'UpArrow',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  --wt
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },

  -- wt
  {
    key = 'LeftArrow',
    mods = 'ALT|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Left', 12 },
  },
  {
    key = 'DownArrow',
    mods = 'ALT|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Down', 3 },
  },
  { key = 'UpArrow',    mods = 'ALT|CTRL',  action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
  {
    key = 'RightArrow',
    mods = 'ALT|CTRL',
    action = wezterm.action.AdjustPaneSize { 'Right', 12 },
  },

  --tmux
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
      timeout_milliseconds = 1000,
    },
  },

  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'activate_pane',
      one_shot = false,
      timeout_milliseconds = 1000,
    },
  },

  -- tmux
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- wt
  {
    key = 'z',
    mods = 'ALT|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },

  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },

  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.RotatePanes 'CounterClockwise',
  },
  { key = 'RightArrow', mods = 'SHIFT|ALT', action = wezterm.action.RotatePanes 'Clockwise' },
}

config.key_tables = {
  copy_mode = copy_mode,
  activate_pane = {
    {
      key = 'UpArrow',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'LeftArrow',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
  },

  resize_pane = {
    {
      key = 'LeftArrow',
      action = wezterm.action.AdjustPaneSize { 'Left', 12 },
    },
    {
      key = 'DownArrow',
      action = wezterm.action.AdjustPaneSize { 'Down', 3 },
    },
    { key = 'UpArrow', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
    {
      key = 'RightArrow',
      action = wezterm.action.AdjustPaneSize { 'Right', 12 },
    },

    { key = 'Escape',  action = 'PopKeyTable' },
  },
}



-- shell

config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- other

config.audible_bell = 'Disabled'

config.default_cursor_style = 'SteadyBar'

config.scrollback_lines = 10000

-- random

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local screen = wezterm.gui.screens().active
  local dim = window:gui_window():get_dimensions()
  local left = (screen.width - dim.pixel_width) / 2
  local top = (screen.height - dim.pixel_height) / 2 - 42 -- 4k taskbar
  window:gui_window():set_position(left, top)
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = string.gsub(tab.active_pane.title, 'Copy mode: ', '')
  return {
    { Text = string.format('%s:%s', tab.tab_index, title) },
    { Text = ' ' },
  }
end)

wezterm.on('update-status', function(window, pane)
  local color = colors.tab_bar.active_tab.fg_color
  for _, item in ipairs(window:active_tab():panes_with_info()) do
    if item.is_active and item.is_zoomed then
      color = colors.ansi[6]
    end
  end
  if window:composition_status() or window:leader_is_active() then
    color = colors.compose_cursor
  end
  if window:active_key_table() then
    color = colors.ansi[3]
  end

  window:set_left_status(wezterm.format {
    { Foreground = { Color = color } },
    { Background = { Color = colors.tab_bar.background } },
    { Text = ' ●• ' },
  } .. wezterm.format {
    { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
    { Background = { Color = colors.tab_bar.background } },
    { Text = pane:get_domain_name() .. ' ' },
  } .. wezterm.format {
    { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
    { Background = { Color = colors.tab_bar.background } },
    { Text = window:active_tab():tab_id() .. ':' .. pane:pane_id() .. ' ' },
  })
end)

wezterm.on('format-window-title', function(tab)
  return tab.active_pane.title
end)

return config
