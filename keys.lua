local M = {}

local palette = require('palette').gruvbox_material_dark()

function M.config(wezterm, config)
  local act = wezterm.action

  config.leader = { mods = 'CTRL', key = 'x', timeout_milliseconds = 5000 }

  -- copy_mode & search_mode (built-in)
  local copy = wezterm.gui.default_key_tables().copy_mode
  table.insert(copy, { key = '/', action = act.Search { CaseInSensitiveString = '' } })
  table.insert(copy, { mods = 'CTRL', key = 'q', action = act.CopyMode { SetSelectionMode = 'Block' } })

  config.key_tables = {
    copy_mode = copy,

    pane = {
      { mods = 'ALT', key = 'P', action = 'PopKeyTable' },

      { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
      { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
      { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
      { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

      { key = 'Tab', action = act.ActivatePaneDirection 'Next' },
      { mods = 'SHIFT', key = 'Tab', action = act.ActivatePaneDirection 'Prev' },

      {
        key = 'r',
        action = act.Multiple { act.SplitHorizontal { domain = 'CurrentPaneDomain' }, 'PopKeyTable' },
      },
      {
        key = 'd',
        action = act.Multiple { act.SplitVertical { domain = 'CurrentPaneDomain' }, 'PopKeyTable' },
      },

      { key = 'z', action = act.Multiple { act.TogglePaneZoomState, 'PopKeyTable' } },

      { key = 'q', action = act.Multiple { act.QuickSelect, 'PopKeyTable' } },
      {
        key = 'l',
        action = act.Multiple {
          act.QuickSelectArgs {
            label = 'open',
            patterns = { 'https?://[^\\s)]+' },
            skip_action_on_paste = true,
            action = wezterm.action_callback(function(window, pane)
              wezterm.open_with(window:get_selection_text_for_pane(pane))
            end),
          },
          'PopKeyTable',
        },
      },

      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
    },

    resize = {
      { mods = 'ALT', key = 'R', action = 'PopKeyTable' },

      { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 16 } },
      { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 4 } },
      { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 4 } },
      { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 16 } },

      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
    },

    move = {
      { mods = 'ALT', key = 'M', action = 'PopKeyTable' },

      { key = 'RightArrow', action = act.RotatePanes 'Clockwise' },
      { key = 'LeftArrow', action = act.RotatePanes 'CounterClockwise' },

      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
    },

    tab = {
      { mods = 'ALT', key = 'T', action = 'PopKeyTable' },

      { key = 'n', action = act.Multiple { act.SpawnTab 'CurrentPaneDomain', 'PopKeyTable' } },

      { key = 'LeftArrow', action = act.ActivateTabRelative(-1) },
      { key = 'RightArrow', action = act.ActivateTabRelative(1) },

      { key = '[', action = act.ActivateTabRelative(-1) },
      { key = ']', action = act.ActivateTabRelative(1) },

      { key = '1', action = act.Multiple { act.ActivateTab(0), 'PopKeyTable' } },
      { key = '2', action = act.Multiple { act.ActivateTab(1), 'PopKeyTable' } },
      { key = '3', action = act.Multiple { act.ActivateTab(2), 'PopKeyTable' } },
      { key = '4', action = act.Multiple { act.ActivateTab(3), 'PopKeyTable' } },
      { key = '5', action = act.Multiple { act.ActivateTab(4), 'PopKeyTable' } },
      { key = '6', action = act.Multiple { act.ActivateTab(5), 'PopKeyTable' } },
      { key = '7', action = act.Multiple { act.ActivateTab(6), 'PopKeyTable' } },
      { key = '8', action = act.Multiple { act.ActivateTab(7), 'PopKeyTable' } },
      { key = '9', action = act.Multiple { act.ActivateTab(8), 'PopKeyTable' } },

      { key = 'Tab', action = 'ActivateLastTab' },

      {
        key = 'b',
        action = act.Multiple {
          wezterm.action_callback(function(window, pane)
            pane:move_to_new_tab()
            pane:activate()
          end),
          'PopKeyTable',
        },
      },

      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
    },

    mux = {
      { mods = 'ALT', key = 'O', action = 'PopKeyTable' },

      {
        key = 'o',
        action = act.Multiple {
          act.ShowLauncherArgs {
            title = 'mux',
            fuzzy_help_text = wezterm.format { { Foreground = { Color = palette.grey1 } }, { Text = 'Mux: ' } },
            flags = 'FUZZY|WORKSPACES|DOMAINS',
          },
          'PopKeyTable',
        },
      },

      {
        key = 'n',
        action = act.Multiple {
          act.PromptInputLine {
            description = wezterm.format { { Foreground = { Color = palette.grey1 } }, { Text = 'New workspace:' } },
            action = wezterm.action_callback(function(window, pane, line)
              if line then
                window:perform_action(act.SwitchToWorkspace { name = line }, pane)
              end
            end),
          },
          'PopKeyTable',
        },
      },

      { key = 'LeftArrow', action = act.SwitchWorkspaceRelative(-1) },
      { key = 'RightArrow', action = act.SwitchWorkspaceRelative(1) },

      { key = 'Enter', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
    },
  }

  config.keys = {
    -- modes

    { mods = 'LEADER', key = 'c', action = act.ActivateCopyMode }, -- copy_mode
    { mods = 'ALT', key = 'C', action = act.ActivateCopyMode },

    { mods = 'ALT', key = 'F', action = act.Search { CaseInSensitiveString = '' } }, -- search_mode

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

    {
      mods = 'ALT',
      key = 'M',
      action = act.ActivateKeyTable { name = 'move', one_shot = false },
    },

    {
      mods = 'ALT',
      key = 'T',
      action = act.ActivateKeyTable { name = 'tab', one_shot = false },
    },

    {
      mods = 'ALT',
      key = 'O',
      action = act.ActivateKeyTable { name = 'mux', one_shot = false },
    },

    -- scroll

    { mods = 'CTRL|SHIFT', key = 'UpArrow', action = act.ScrollByLine(-1) },
    { mods = 'CTRL|SHIFT', key = 'DownArrow', action = act.ScrollByLine(1) },

    { mods = 'CTRL|SHIFT', key = 'PageUp', action = act.ScrollByPage(-1) },
    { mods = 'CTRL|SHIFT', key = 'PageDown', action = act.ScrollByPage(1) },

    { mods = 'CTRL|SHIFT', key = 'Home', action = act.ScrollToTop },
    { mods = 'CTRL|SHIFT', key = 'End', action = act.ScrollToBottom },

    -- panes

    { mods = 'LEADER', key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = 'LEADER', key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

    { mods = 'ALT', key = 'r', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { mods = 'ALT', key = 'd', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

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
    {
      mods = 'LEADER',
      key = 'l',
      action = act.Multiple {
        act.QuickSelectArgs {
          label = 'open',
          patterns = { 'https?://[^\\s)]+' },
          skip_action_on_paste = true,
          action = wezterm.action_callback(function(window, pane)
            wezterm.open_with(window:get_selection_text_for_pane(pane))
          end),
        },
        'PopKeyTable',
      },
    },

    -- tabs

    { mods = 'LEADER', key = '[', action = act.ActivateTabRelative(-1) },
    { mods = 'LEADER', key = ']', action = act.ActivateTabRelative(1) },

    {
      mods = 'LEADER',
      key = 'b',
      action = wezterm.action_callback(function(window, pane)
        pane:move_to_new_tab()
        pane:activate()
      end),
    },

    -- mux

    {
      mods = 'LEADER',
      key = 'o',
      action = act.ShowLauncherArgs {
        title = 'mux',
        fuzzy_help_text = wezterm.format { { Foreground = { Color = palette.grey1 } }, { Text = 'Mux: ' } },
        flags = 'FUZZY|WORKSPACES|DOMAINS',
      },
    },

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
    {
      mods = 'CTRL|SHIFT',
      key = 'Backspace',
      action = wezterm.action_callback(function(window, pane)
        require('opacity').reset(window, config)
      end),
    },

    -- workarounds

    { mods = 'LEADER|CTRL', key = 'x', action = act.SendKey { mods = 'CTRL', key = 'x' } },

    -- config

    { mods = 'CTRL|SHIFT', key = 'F5', action = act.ReloadConfiguration },

    -- trash keys

    { mods = 'CTRL|SHIFT', key = 'Space', action = act.DisableDefaultAssignment },
    { mods = 'CTRL|SHIFT', key = 'r', action = act.DisableDefaultAssignment },
    { mods = 'CTRL|SHIFT', key = 'x', action = act.DisableDefaultAssignment },

    { mods = 'CTRL', key = 'PageUp', action = act.DisableDefaultAssignment },
    { mods = 'CTRL', key = 'PageDown', action = act.DisableDefaultAssignment },
  }
end

return M
