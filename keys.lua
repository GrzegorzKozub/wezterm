local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action

  concat(config.keys, {
    -- wezterm

    { key = 'F1', action = act.ActivateCommandPalette },
    { mods = 'CTRL|SHIFT', key = 'F5', action = act.ReloadConfiguration },

    -- scroll

    { mods = 'CTRL|SHIFT', key = 'UpArrow', action = act.ScrollByLine(-1) },
    { mods = 'CTRL|SHIFT', key = 'DownArrow', action = act.ScrollByLine(1) },

    { mods = 'CTRL|SHIFT', key = 'PageUp', action = act.ScrollByPage(-1) },
    { mods = 'CTRL|SHIFT', key = 'PageDown', action = act.ScrollByPage(1) },

    { mods = 'CTRL|SHIFT', key = 'Home', action = act.ScrollToTop },
    { mods = 'CTRL|SHIFT', key = 'End', action = act.ScrollToBottom },

    -- workarounds

    { mods = 'LEADER|CTRL', key = 'x', action = act.SendKey { mods = 'CTRL', key = 'x' } },

    -- trash keys

    { mods = 'CTRL|SHIFT', key = 'Space', action = act.DisableDefaultAssignment },
    { mods = 'CTRL|SHIFT', key = 'r', action = act.DisableDefaultAssignment },
    { mods = 'CTRL|SHIFT', key = 'x', action = act.DisableDefaultAssignment },

    { mods = 'CTRL', key = 'PageUp', action = act.DisableDefaultAssignment },
    { mods = 'CTRL', key = 'PageDown', action = act.DisableDefaultAssignment },
  })
end

function M.config(config)
  config.keys = config.keys or {}
  config.key_tables = config.key_tables or {}

  config.leader = { mods = 'CTRL', key = 'x', timeout_milliseconds = 5000 }

  keys(config)
end

return M
