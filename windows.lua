local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action
  local spawn = { domain = 'CurrentPaneDomain', args = config.default_prog }

  concat(config.keys, {
    { mods = 'CTRL|SHIFT', key = 'n', action = act.SpawnCommandInNewWindow(spawn) },

    { key = 'F11', action = act.ToggleFullScreen },

    {
      mods = 'CTRL|SHIFT',
      key = '_',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').decrease(window, config)
      end),
    },
    {
      mods = 'CTRL|SHIFT',
      key = '+',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').increase(window, config)
      end),
    },
    {
      mods = 'CTRL|SHIFT',
      key = 'Backspace',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').reset(window, config)
      end),
    },
  })
end

function M.config(config)
  config.window_background_opacity = 0.95

  -- https://github.com/wezterm/wezterm/issues/5873
  -- https://github.com/wezterm/wezterm/issues/6767
  -- config.win32_system_backdrop = 'Tabbed'

  config.window_decorations = 'RESIZE' -- INTEGRATED_BUTTONS

  config.window_padding = { left = '8pt', bottom = 0, top = '8pt', right = '8pt' }

  config.window_frame = {
    border_bottom_color = config.color_schemes[config.color_scheme].tab_bar.background,
    border_bottom_height = '8pt',
  }

  config.window_close_confirmation = 'NeverPrompt'

  config.initial_cols = 120
  config.initial_rows = 30

  config.adjust_window_size_when_changing_font_size = false

  wezterm.on('gui-attached', function(domain)
    local screen = wezterm.gui.screens().active
    for _, mux_window in ipairs(wezterm.mux.all_windows()) do
      local gui_window = mux_window:gui_window()
      if domain ~= 'unix' then
        gui_window:perform_action(wezterm.action.ResetFontAndWindowSize, mux_window:active_pane())
      end
      local dim = gui_window:get_dimensions()
      local left = (screen.width - dim.pixel_width) / 2
      local top = (screen.height - dim.pixel_height) / 2 - 84 -- taskbar on 4k at 200%
      gui_window:set_position(left, top)
      gui_window:set_inner_size(dim.pixel_width, dim.pixel_height)
    end
  end)

  wezterm.on('format-window-title', function(tab, pane) -- tabs, panes, config
    return string.format(
      '%s %s %s:%s %s',
      wezterm.mux.get_active_workspace(),
      pane.domain_name,
      tab.tab_index,
      tab.active_pane.pane_index,
      tab.active_pane.title
    )
  end)

  keys(config)
end

return M
