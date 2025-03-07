local M = {}

function M.config(wezterm, config)
  local act = wezterm.action

  config.leader = { mods = 'CTRL', key = 'x', timeout_milliseconds = 5000 }

  -- TODO

  local copy = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy, { key = '/', action = act.Search { CaseInSensitiveString = '' } })
  table.insert(copy, { mods = 'CTRL', key = 'q', action = act.CopyMode { SetSelectionMode = 'Block' } })

  config.key_tables = {
    copy_mode = copy,

    pane = {
      { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
      { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
      { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
      { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
    },

    resize = {
      { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 12 } },
      { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 3 } },
      { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 3 } },
      { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 12 } },
      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
    },
  }

  config.keys = {

    -- modes: copy_mode, dearch_mode, pane, resize
    -- TODO

    { mods = 'LEADER', key = 'c', action = act.ActivateCopyMode },
    { mods = 'ALT', key = 'C', action = act.ActivateCopyMode },

    { mods = 'SHIFT|CTRL', key = 'f', action = act.Search { CaseInSensitiveString = '' } },

    {
      mods = 'ALT',
      key = 'P',
      action = act.ActivateKeyTable { name = 'pane', one_shot = false },
    },

    {
      mods = 'ALT',
      key = 'R',
      action = act.ActivateKeyTable { name = 'resize', one_shot = false },
    },

    -- panes

    { mods = 'LEADER', key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = 'LEADER', key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

    { mods = 'ALT', key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = 'ALT', key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

    { mods = 'LEADER', key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { mods = 'LEADER', key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { mods = 'LEADER', key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = 'LEADER', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

    { mods = 'ALT', key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { mods = 'ALT', key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { mods = 'ALT', key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { mods = 'ALT', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

    { mods = 'LEADER|CTRL', key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 16 } },
    { mods = 'LEADER|CTRL', key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 4 } },
    { mods = 'LEADER|CTRL', key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 4 } },
    { mods = 'LEADER|CTRL', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 16 } },

    { mods = 'LEADER', key = 'z', action = act.TogglePaneZoomState },
    { mods = 'ALT', key = 'z', action = act.TogglePaneZoomState },

    { mods = 'LEADER|SHIFT', key = 'RightArrow', action = act.RotatePanes 'Clockwise' },
    { mods = 'LEADER|SHIFT', key = 'LeftArrow', action = act.RotatePanes 'CounterClockwise' },

    { mods = 'CTRL|SHIFT', key = 'UpArrow', action = act.ScrollByLine(-1) },
    { mods = 'CTRL|SHIFT', key = 'DownArrow', action = act.ScrollByLine(1) },

    { mods = 'CTRL|SHIFT', key = 'PageUp', action = act.ScrollByPage(-1) },
    { mods = 'CTRL|SHIFT', key = 'PageDown', action = act.ScrollByPage(1) },

    { mods = 'CTRL|SHIFT', key = 'Home', action = act.ScrollToTop },
    { mods = 'CTRL|SHIFT', key = 'End', action = act.ScrollToBottom },

    -- tabs
    -- TODO

    { mods = 'LEADER', key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },

    { mods = 'LEADER', key = 'p', action = act.ActivateTabRelative(-1) },
    { mods = 'LEADER', key = 'n', action = act.ActivateTabRelative(1) },

    -- window

    { key = 'F1', action = act.ActivateCommandPalette },
    { key = 'F11', action = act.ToggleFullScreen },

    {
      mods = 'CTRL|SHIFT',
      key = '_',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').decrease(window, config)
      end),
    },
    {
      mods = 'CTRL|SHIFT',
      key = '+',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').increase(window, config)
      end),
    },

    -- workarounds

    { mods = 'LEADER|CTRL', key = 'x', action = act.SendKey { mods = 'CTRL', key = 'x' } },

    -- trash keys

    { mods = 'CTRL|SHIFT', key = 'x', action = act.Nop },
  }
end

return M
