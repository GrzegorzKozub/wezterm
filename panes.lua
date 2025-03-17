local M = {}

local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action
  local spawn = { domain = 'CurrentPaneDomain', args = config.default_prog }

  local link = act.Multiple {
    act.QuickSelectArgs {
      label = 'open',
      patterns = { 'https?://[^\\s)]+' },
      skip_action_on_paste = true,
      action = wezterm.action_callback(function(window, pane)
        wezterm.open_with(window:get_selection_text_for_pane(pane))
      end),
    },
    'PopKeyTable',
  }

  concat(config.keys, {
    { mods = 'ALT', key = 'P', action = act.ActivateKeyTable { name = 'pane', one_shot = false } },

    { mods = 'LEADER', key = 'r', action = act.SplitHorizontal(spawn) },
    { mods = 'LEADER', key = 'd', action = act.SplitVertical(spawn) },

    { mods = 'ALT', key = 'r', action = act.SplitHorizontal(spawn) },
    { mods = 'ALT', key = 'd', action = act.SplitVertical(spawn) },

    -- { mods = 'LEADER', key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    -- { mods = 'LEADER', key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    -- { mods = 'LEADER', key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    -- { mods = 'LEADER', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

    { mods = 'ALT', key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { mods = 'ALT', key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { mods = 'ALT', key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = 'ALT', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

    -- { mods = 'LEADER|CTRL', key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 16 } },
    -- { mods = 'LEADER|CTRL', key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 4 } },
    -- { mods = 'LEADER|CTRL', key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 4 } },
    -- { mods = 'LEADER|CTRL', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 16 } },

    { mods = 'LEADER', key = 'z', action = act.TogglePaneZoomState },
    { mods = 'ALT', key = 'z', action = act.TogglePaneZoomState },

    -- { mods = 'LEADER|SHIFT', key = 'RightArrow', action = act.RotatePanes 'Clockwise' },
    -- { mods = 'LEADER|SHIFT', key = 'LeftArrow', action = act.RotatePanes 'CounterClockwise' },

    { mods = 'LEADER', key = 'q', action = act.QuickSelect },
    { mods = 'LEADER', key = 'l', action = link },
  })

  config.key_tables['pane'] = {
    { mods = 'ALT', key = 'P', action = 'PopKeyTable' },

    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

    { key = 'Tab', action = act.ActivatePaneDirection 'Next' },
    { mods = 'SHIFT', key = 'Tab', action = act.ActivatePaneDirection 'Prev' },

    { key = 'r', action = act.Multiple { act.SplitHorizontal(spawn), 'PopKeyTable' } },
    { key = 'd', action = act.Multiple { act.SplitVertical(spawn), 'PopKeyTable' } },

    { key = 'z', action = act.Multiple { act.TogglePaneZoomState, 'PopKeyTable' } },

    { key = 'q', action = act.Multiple { act.QuickSelect, 'PopKeyTable' } },
    { key = 'l', action = link },

    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  }
end

function M.config(config)
  config.inactive_pane_hsb = { brightness = 0.9, saturation = 0.9 }
  config.scrollback_lines = 10000

  keys(config)
end

return M
