local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

function M.config(config)
  local act = wezterm.action

  concat(config.keys, {
    { mods = 'ALT', key = 'R', action = act.ActivateKeyTable { name = 'resize', one_shot = false } },
  })

  config.key_tables['resize'] = {
    { mods = 'ALT', key = 'R', action = 'PopKeyTable' },

    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 16 } },
    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 4 } },
    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 4 } },
    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 16 } },

    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  }
end

return M
