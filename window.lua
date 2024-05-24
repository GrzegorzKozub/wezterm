local M = {}

function M.config(wezterm, config)
  config.window_background_opacity = 0.95
  config.win32_system_backdrop = 'Mica'

  config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'

  config.window_padding = { left = 16, right = 16, top = 16, bottom = 0 }

  config.window_frame = {
    border_bottom_color = config.color_schemes[config.color_scheme].tab_bar.background,
    border_bottom_height = 12,
    font = wezterm.font 'Segoe UI',
  }

  config.window_close_confirmation = 'NeverPrompt'

  config.initial_cols = 160
  config.initial_rows = 40

  wezterm.on('gui-startup', function(cmd)
    -- luacheck: push ignore 211
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    -- luacheck: pop
    local screen = wezterm.gui.screens().active
    local dim = window:gui_window():get_dimensions()
    local left = (screen.width - dim.pixel_width) / 2
    local top = (screen.height - dim.pixel_height) / 2 - 42 -- taskbar on 4k at 150%
    window:gui_window():set_position(left, top)
    window:gui_window():set_inner_size(dim.pixel_width, dim.pixel_height)
  end)

  wezterm.on('format-window-title', function(tab)
    return tab.active_pane.title
  end)
end

return M