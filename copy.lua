local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

function M.config(config)
  local act = wezterm.action

  concat(config.keys, {
    { mods = 'LEADER', key = 'c', action = act.ActivateCopyMode }, -- copy_mode
    { mods = 'ALT', key = 'C', action = act.ActivateCopyMode },

    { mods = 'ALT', key = 'F', action = act.Search { CaseInSensitiveString = '' } }, -- search_mode
  })

  local copy = wezterm.gui.default_key_tables().copy_mode

  concat(copy, {
    { key = '/', action = act.Search { CaseInSensitiveString = '' } },
    { mods = 'CTRL', key = 'q', action = act.CopyMode { SetSelectionMode = 'Block' } },
  })

  config.key_tables['copy_mode'] = copy
end

return M
