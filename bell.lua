local M = {}

-- test with echo `a

local wezterm = require 'wezterm'

local rung = false

function M.check()
  return rung
end

function M.clear()
  rung = false
end

function M.config(config)
  config.audible_bell = 'Disabled'

  wezterm.on('bell', function(window, pane)
    rung = not rung
  end)
end

return M
