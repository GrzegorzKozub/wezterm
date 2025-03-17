local M = {}

local colors = require 'colors'
local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action
  local spawn = { domain = 'CurrentPaneDomain', args = config.default_prog }

  local move = act.Multiple {
    wezterm.action_callback(function(window, pane)
      pane:move_to_new_tab()
      pane:activate()
    end),
    'PopKeyTable',
  }

  concat(config.keys, {
    { mods = 'ALT', key = 'T', action = act.ActivateKeyTable { name = 'tab', one_shot = false } },

    { mods = 'CTRL|SHIFT', key = 't', action = act.SpawnCommandInNewTab(spawn) },

    { mods = 'LEADER', key = '[', action = act.ActivateTabRelative(-1) },
    { mods = 'LEADER', key = ']', action = act.ActivateTabRelative(1) },

    { mods = 'LEADER', key = 'b', action = move },
  })

  config.key_tables['tab'] = {
    { mods = 'ALT', key = 'T', action = 'PopKeyTable' },

    { key = 'n', action = act.Multiple { act.SpawnCommandInNewTab(spawn), 'PopKeyTable' } },

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

    { key = 'b', action = move },

    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  }
end

local function fg_color(tab)
  if tab.is_active then
    return colors.bg5
  else
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        return colors.term_white
      end
    end
    return colors.bg3
  end
end

local function progress_icon(percentage)
  local icons = { '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥' }
  return icons[math.floor(percentage / 12) + 1]
end

local function progress(pane)
  local icon, color = nil, colors.bg5
  if pane.progress then
    if pane.progress.Percentage ~= nil then
      icon = progress_icon(pane.progress.Percentage)
      color = colors.term_green
    elseif pane.progress.Error ~= nil then
      icon = progress_icon(pane.progress.Error)
      color = colors.term_red
    elseif pane.progress == 'Indeterminate' then
      icon = '󰪡'
      color = colors.term_blue
    end
  end
  return {
    { Foreground = { Color = color } },
    { Text = icon and ' ' .. icon or '' },
  }
end

function M.config(config)
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true

  config.tab_max_width = 32
  config.show_new_tab_button_in_tab_bar = false

  local new = '󰐕'
  local close = ' 󰖭 '
  local hide = ' 󰖰 '
  local maximize = ' 󰖯 '

  config.tab_bar_style = {
    new_tab = wezterm.format { { Text = new } },
    new_tab_hover = wezterm.format { { Text = new } },

    window_hide = wezterm.format { { Text = hide } },
    window_hide_hover = wezterm.format { { Text = hide } },

    window_maximize = wezterm.format { { Text = maximize } },
    window_maximize_hover = wezterm.format { { Text = maximize } },

    window_close = wezterm.format { { Text = close } },
    window_close_hover = wezterm.format {
      { Foreground = { Color = colors.term_red } },
      { Text = close },
    },
  }

  wezterm.on('format-tab-title', function(tab) -- tabs, panes, config, hover, max_width
    return wezterm.format {
      { Foreground = { Color = fg_color(tab) } },
      {
        Text = string.format(
          ' %s:%s %s',
          tab.tab_index,
          tab.active_pane.pane_index,
          string.gsub(tab.active_pane.title, 'Copy mode: ', '')
        ),
      },
    } .. wezterm.format(progress(tab.active_pane)) .. wezterm.format {
      { Foreground = { Color = fg_color(tab) } },
      { Text = tab.active_pane.is_zoomed and ' ' or '' },
    }
  end)

  keys(config)
end

return M
