local M = {}

local bell = require 'bell'
local colors = require 'colors'
local concat = require('util').concat
local wezterm = require 'wezterm'

local function keys(config)
  local act = wezterm.action
  local spawn = { domain = 'CurrentPaneDomain', args = config.default_prog }

  local bell_clear = wezterm.action_callback(function(window, pane)
    bell.clear(window:active_tab():tab_id())
  end)

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

    { mods = 'CTRL|SHIFT', key = 'Tab', action = act.Multiple { act.ActivateTabRelative(-1), bell_clear } },
    { mods = 'CTRL', key = 'Tab', action = act.Multiple { act.ActivateTabRelative(1), bell_clear } },

    { mods = 'LEADER', key = '[', action = act.Multiple { act.ActivateTabRelative(-1), bell_clear } },
    { mods = 'LEADER', key = ']', action = act.Multiple { act.ActivateTabRelative(1), bell_clear } },

    { mods = 'LEADER', key = 'b', action = move },
  })

  config.key_tables['tab'] = {
    { mods = 'ALT', key = 'T', action = 'PopKeyTable' },

    { key = 'n', action = act.Multiple { act.SpawnCommandInNewTab(spawn), 'PopKeyTable' } },

    { key = 'LeftArrow', action = act.Multiple { act.ActivateTabRelative(-1), bell_clear } },
    { key = 'RightArrow', action = act.Multiple { act.ActivateTabRelative(1), bell_clear } },

    { key = '[', action = act.Multiple { act.ActivateTabRelative(-1), bell_clear } },
    { key = ']', action = act.Multiple { act.ActivateTabRelative(1), bell_clear } },

    { key = '1', action = act.Multiple { act.ActivateTab(0), bell_clear, 'PopKeyTable' } },
    { key = '2', action = act.Multiple { act.ActivateTab(1), bell_clear, 'PopKeyTable' } },
    { key = '3', action = act.Multiple { act.ActivateTab(2), bell_clear, 'PopKeyTable' } },
    { key = '4', action = act.Multiple { act.ActivateTab(3), bell_clear, 'PopKeyTable' } },
    { key = '5', action = act.Multiple { act.ActivateTab(4), bell_clear, 'PopKeyTable' } },
    { key = '6', action = act.Multiple { act.ActivateTab(5), bell_clear, 'PopKeyTable' } },
    { key = '7', action = act.Multiple { act.ActivateTab(6), bell_clear, 'PopKeyTable' } },
    { key = '8', action = act.Multiple { act.ActivateTab(7), bell_clear, 'PopKeyTable' } },
    { key = '9', action = act.Multiple { act.ActivateTab(8), bell_clear, 'PopKeyTable' } },

    { key = 'Tab', action = act.Multiple { 'ActivateLastTab', bell_clear } },

    { key = 'b', action = move },

    { key = 'Enter', action = 'PopKeyTable' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  }
end

local function unseen(tab)
  if tab.is_active then
    return false
  end
  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      return true
    end
  end
  return false
end

local function fg_color(tab)
  if bell.check(tab.tab_id) then
    return colors.term_yellow
  elseif tab.is_active then
    return colors.bg5
  elseif unseen(tab) then
    return colors.term_white
  end
  return colors.bg3
end

local function title(pane)
  return string.gsub(string.gsub(pane.title, 'Copy mode: ', ''), 'Administrator: ', '')
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

local function admin(pane)
  local icon, color = nil, colors.bg5
  if string.match(pane.title, 'Administrator: ') then
    icon = '󰒘'
    color = colors.term_yellow
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
      { Text = string.format(' %s:%s %s', tab.tab_index, tab.active_pane.pane_index, title(tab.active_pane)) },
    } .. wezterm.format(admin(tab.active_pane)) .. wezterm.format {
      { Foreground = { Color = fg_color(tab) } },
      {
        Text = (tab.active_pane.is_zoomed and ' ' or '')
          .. (bell.check(tab.tab_id) and ' ' or (unseen(tab) and ' ' or '')),
      },
    } .. wezterm.format(progress(tab.active_pane))
  end)

  keys(config)
end

return M