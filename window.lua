local M = {}

function M.config(wezterm, config)
  config.window_background_opacity = 0.95

  -- https://github.com/wezterm/wezterm/issues/5873
  -- https://github.com/wezterm/wezterm/issues/6767
  -- config.win32_system_backdrop = 'Tabbed'

  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

  config.window_padding = { left = '8pt', right = '8pt', top = '8pt', bottom = 0 }

  config.window_frame = {
    border_bottom_color = config.color_schemes[config.color_scheme].tab_bar.background,
    border_bottom_height = '8pt',
    font = wezterm.font 'Segoe UI',
  }

  config.window_close_confirmation = 'NeverPrompt'

  config.initial_cols = 120
  config.initial_rows = 30

  config.adjust_window_size_when_changing_font_size = false

  wezterm.on('gui-startup', function(cmd)
    -- luacheck: push ignore 211
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    -- luacheck: pop
    local screen = wezterm.gui.screens().active
    local dim = window:gui_window():get_dimensions()
    local left = (screen.width - dim.pixel_width) / 2
    local top = (screen.height - dim.pixel_height) / 2 - 84 -- taskbar on 4k at 200%
    window:gui_window():set_position(left, top)
    window:gui_window():set_inner_size(dim.pixel_width, dim.pixel_height)
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
end

return M