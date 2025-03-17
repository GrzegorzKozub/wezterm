local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

function M.config(config)
  local act = wezterm.action

  concat(config.keys, {
    { mods = 'ALT', key = 'M', action = act.ActivateKeyTable { name = 'move', one_shot = false } },
  })

  config.key_tables['move'] = {
    { mods = 'ALT', key = 'M', action = 'PopKeyTable' },

    { key = 'RightArrow', action = act.RotatePanes 'Clockwise' },
    { key = 'LeftArrow', action = act.RotatePanes 'CounterClockwise' },

    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  }
end

return M
