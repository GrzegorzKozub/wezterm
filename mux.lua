local M = {}

local colors = require 'colors'
local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action

  local menu = act.Multiple {
    act.ShowLauncherArgs {
      title = 'mux',
      fuzzy_help_text = wezterm.format { { Foreground = { Color = colors.grey1 } }, { Text = 'Mux: ' } },
      flags = 'FUZZY|WORKSPACES|DOMAINS',
    },
    'PopKeyTable',
  }

  concat(config.keys, {
    { mods = 'ALT', key = 'O', action = act.ActivateKeyTable { name = 'mux', one_shot = false } },

    { mods = 'LEADER', key = 'o', action = menu },
  })

  config.key_tables['mux'] = {
    { mods = 'ALT', key = 'O', action = 'PopKeyTable' },

    { key = 'o', action = menu },

    {
      key = 'n',
      action = act.Multiple {
        act.PromptInputLine {
          description = wezterm.format { { Foreground = { Color = colors.grey1 } }, { Text = 'New workspace:' } },
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
  }
end

function M.config(config)
  config.default_prog = { 'pwsh', '-NoLogo' }

  config.ssh_domains = {}
  config.unix_domains = {
    {
      name = 'unix',
      serve_command = concat({ 'wezterm-mux-server', '--daemonize' }, config.default_prog),
      skip_permissions_check = true,
    },
  }

  -- config.default_domain = 'unix'
  -- config.default_gui_startup_args = concat({ 'connect', 'unix' }, config.default_prog)

  keys(config)
end

return M
