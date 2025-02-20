local M = {}

function M.config(wezterm, config)
  config.leader = { mods = 'CTRL', key = 'x', timeout_milliseconds = 5000 }

  config.keys = {
    -- history

    { mods = 'CTRL|SHIFT', key = 'UpArrow', action = wezterm.action.ScrollByLine(-1) },
    { mods = 'CTRL|SHIFT', key = 'DownArrow', action = wezterm.action.ScrollByLine(1) },
    { mods = 'CTRL|SHIFT', key = 'PageUp', action = wezterm.action.ScrollByPage(-1) },
    { mods = 'CTRL|SHIFT', key = 'PageDown', action = wezterm.action.ScrollByPage(1) },

    { mods = 'CTRL|SHIFT', key = 'Home', action = wezterm.action.ScrollToTop },
    { mods = 'CTRL|SHIFT', key = 'End', action = wezterm.action.ScrollToBottom },

    -- pane split

    { mods = 'LEADER', key = 'h', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = 'LEADER', key = 'v', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    { mods = 'ALT|SHIFT', key = 'h', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = 'ALT|SHIFT', key = 'v', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- pane activation

    {
      mods = 'LEADER',
      key = 'a',
      action = wezterm.action.ActivateKeyTable {
        name = 'activate_pane',
        one_shot = false,
        timeout_milliseconds = 1000,
      },
    },

    { mods = 'LEADER', key = 'LeftArrow', action = wezterm.action.ActivatePaneDirection 'Left' },
    { mods = 'LEADER', key = 'DownArrow', action = wezterm.action.ActivatePaneDirection 'Down' },
    { mods = 'LEADER', key = 'UpArrow', action = wezterm.action.ActivatePaneDirection 'Up' },
    { mods = 'LEADER', key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },

    { mods = 'ALT', key = 'LeftArrow', action = wezterm.action.ActivatePaneDirection 'Left' },
    { mods = 'ALT', key = 'DownArrow', action = wezterm.action.ActivatePaneDirection 'Down' },
    { mods = 'ALT', key = 'UpArrow', action = wezterm.action.ActivatePaneDirection 'Up' },
    { mods = 'ALT', key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },

    -- pane size

    {
      mods = 'LEADER',
      key = 'r',
      action = wezterm.action.ActivateKeyTable { name = 'resize_pane', one_shot = false, timeout_milliseconds = 1000 },
    },

    { mods = 'ALT|CTRL', key = 'LeftArrow', action = wezterm.action.AdjustPaneSize { 'Left', 12 } },
    { mods = 'ALT|CTRL', key = 'DownArrow', action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
    { mods = 'ALT|CTRL', key = 'UpArrow', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
    { mods = 'ALT|CTRL', key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 12 } },

    -- pane rotation

    { mods = 'SHIFT|ALT', key = 'RightArrow', action = wezterm.action.RotatePanes 'Clockwise' },
    { mods = 'SHIFT|ALT', key = 'LeftArrow', action = wezterm.action.RotatePanes 'CounterClockwise' },

    -- pane zoom

    { mods = 'LEADER', key = 'z', action = wezterm.action.TogglePaneZoomState },
    { mods = 'ALT|SHIFT', key = 'z', action = wezterm.action.TogglePaneZoomState },

    -- pane search

    { mods = 'SHIFT|CTRL', key = 'f', action = wezterm.action.Search { CaseInSensitiveString = '' } },

    -- tabs

    { mods = 'LEADER', key = 'c', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

    { mods = 'LEADER', key = 'p', action = wezterm.action.ActivateTabRelative(-1) },
    { mods = 'LEADER', key = 'n', action = wezterm.action.ActivateTabRelative(1) },

    -- window

    { key = 'F1', action = wezterm.action.ActivateCommandPalette },
    { key = 'F11', action = wezterm.action.ToggleFullScreen },

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

    -- copy mode

    { mods = 'LEADER', key = '[', action = wezterm.action.ActivateCopyMode },
    { mods = 'CTRL|SHIFT', key = '{', action = wezterm.action.ActivateCopyMode },
  }

  local copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy_mode, { key = '/', action = wezterm.action.Search { CaseInSensitiveString = '' } })
  table.insert(copy_mode, { mods = 'CTRL', key = 'q', action = wezterm.action.CopyMode { SetSelectionMode = 'Block' } })

  config.key_tables = {
    copy_mode = copy_mode,

    activate_pane = {
      { key = 'LeftArrow', action = wezterm.action.ActivatePaneDirection 'Left' },
      { key = 'DownArrow', action = wezterm.action.ActivatePaneDirection 'Down' },
      { key = 'UpArrow', action = wezterm.action.ActivatePaneDirection 'Up' },
      { key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },
      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
    },

    resize_pane = {
      { key = 'LeftArrow', action = wezterm.action.AdjustPaneSize { 'Left', 12 } },
      { key = 'DownArrow', action = wezterm.action.AdjustPaneSize { 'Down', 3 } },
      { key = 'UpArrow', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
      { key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 12 } },
      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
    },
  }
end

return M