local M = {}

function M.config(wezterm, config)
  local copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(
    copy_mode,

    {


      key = 'q',
      mods = 'CTRL',
      action = wezterm.action.CopyMode { SetSelectionMode = 'Block' },
    }

  )

  config.leader = { key = 'x', mods = 'CTRL', timeout_milliseconds = 5000 }

  config.keys = {


    {
      key = 'f',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.Search { CaseInSensitiveString = '' },
    },

    {
      key = '{',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateCopyMode,
    },

    {
      key = '[',
      mods = 'LEADER',
      action = wezterm.action.ActivateCopyMode,
    },




    {
      key = 'PageUp',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByPage(-1),
    },





    {
      key = 'PageDown',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByPage(1),
    },

    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByLine(-1),
    },

    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollByLine(1),
    },

    {
      key = 'Home',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollToTop,
    },

    {
      key = 'End',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ScrollToBottom,
    },

    {
      key = 'F1',
      action = wezterm.action.ActivateCommandPalette,
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'h',
      mods = 'ALT|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'v',
      mods = 'ALT|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'z',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.TogglePaneZoomState,
    },

    -- tmux
    {
      key = 'UpArrow',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'LeftArrow',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },

    --wt
    {
      key = 'UpArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'LeftArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'ALT',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },

    -- wt
    {
      key = 'LeftArrow',
      mods = 'ALT|CTRL',
      action = wezterm.action.AdjustPaneSize { 'Left', 12 },
    },
    {
      key = 'DownArrow',
      mods = 'ALT|CTRL',
      action = wezterm.action.AdjustPaneSize { 'Down', 3 },
    },
    { key = 'UpArrow',    mods = 'ALT|CTRL',  action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
    {
      key = 'RightArrow',
      mods = 'ALT|CTRL',
      action = wezterm.action.AdjustPaneSize { 'Right', 12 },
    },

    --tmux
    {
      key = 'r',
      mods = 'LEADER',
      action = wezterm.action.ActivateKeyTable {
        name = 'resize_pane',
        one_shot = false,
        timeout_milliseconds = 1000,
      },
    },

    {
      key = 'a',
      mods = 'LEADER',
      action = wezterm.action.ActivateKeyTable {
        name = 'activate_pane',
        one_shot = false,
        timeout_milliseconds = 1000,
      },
    },

    -- tmux
    {
      key = 'z',
      mods = 'LEADER',
      action = wezterm.action.TogglePaneZoomState,
    },
    -- wt
    {
      key = 'z',
      mods = 'ALT|SHIFT',
      action = wezterm.action.TogglePaneZoomState,
    },

    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen,
    },

    {
      key = 'LeftArrow',
      mods = 'SHIFT|ALT',
      action = wezterm.action.RotatePanes 'CounterClockwise',
    },
    { key = 'RightArrow', mods = 'SHIFT|ALT', action = wezterm.action.RotatePanes 'Clockwise' },
  }

  config.key_tables = {
    copy_mode = copy_mode,
    activate_pane = {
      {
        key = 'UpArrow',
        action = wezterm.action.ActivatePaneDirection 'Up',
      },
      {
        key = 'DownArrow',
        action = wezterm.action.ActivatePaneDirection 'Down',
      },
      {
        key = 'LeftArrow',
        action = wezterm.action.ActivatePaneDirection 'Left',
      },
      {
        key = 'RightArrow',
        action = wezterm.action.ActivatePaneDirection 'Right',
      },
      { key = 'Escape', action = 'PopKeyTable' },
    },

    resize_pane = {
      {
        key = 'LeftArrow',
        action = wezterm.action.AdjustPaneSize { 'Left', 12 },
      },
      {
        key = 'DownArrow',
        action = wezterm.action.AdjustPaneSize { 'Down', 3 },
      },
      { key = 'UpArrow', action = wezterm.action.AdjustPaneSize { 'Up', 3 } },
      {
        key = 'RightArrow',
        action = wezterm.action.AdjustPaneSize { 'Right', 12 },
      },

      { key = 'Escape',  action = 'PopKeyTable' },
    },
  }
end

return M