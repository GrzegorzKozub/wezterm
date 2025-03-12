local M = {}

function M.config(config)
  config.inactive_pane_hsb = { brightness = 0.9, saturation = 0.9 }
  config.scrollback_lines = 10000
end

return M