local M = {}

function M.config(config)
  config.inactive_pane_hsb = { brightness = 0.8, saturation = 0.9 }
  config.scrollback_lines = 10000
  config.default_cursor_style = 'SteadyBar'
end

return M