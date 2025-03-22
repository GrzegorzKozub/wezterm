local M = {}

local colors = require 'colors'
local sys = require 'sys'
local user = require 'user'
local wezterm = require 'wezterm'

local function mode(window)
  if window:leader_is_active() then
    return '', colors.term_yellow
  elseif window:composition_status() then
    return '󰬴', colors.term_yellow
  end

  local key_table = window:active_key_table()
  if key_table == 'pane' then
    return '', colors.term_yellow
  elseif key_table == 'resize' then
    return '󰁜', colors.term_orange
  elseif key_table == 'move' then
    return '󰁔', colors.term_red
  elseif key_table == 'tab' then
    return '', colors.term_blue
  elseif key_table == 'mux' then
    return '󰣖', colors.term_purple
  elseif key_table == 'copy_mode' then
    return '󰁝', colors.term_green
  elseif key_table == 'search_mode' then
    return '', colors.term_aqua
  end

  return '󰞷', colors.bg5
end

local function admin()
  local icon, color = nil, colors.bg5
  if user.admin() then
    icon = '󰒘'
    color = colors.term_yellow
  end
  return {
    { Foreground = { Color = color } },
    { Text = icon and ' ' .. icon or '' },
  }
end

function M.config()
  wezterm.on('update-status', function(window, pane)
    local icon, color = mode(window)

    window:set_left_status(wezterm.format {
      { Foreground = { Color = color } },
      { Text = ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.bg0 } },
      { Background = { Color = color } },
      { Text = icon },
    } .. wezterm.format {
      { Foreground = { Color = color } },
      { Text = ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.bg5 } },
      { Text = wezterm.mux.get_active_workspace() },
    } .. wezterm.format {
      { Foreground = { Color = colors.bg5 } },
      { Text = ' ' .. pane:get_domain_name() },
    } .. wezterm.format(admin()))

    window:set_right_status(sys.stats())
  end)
end

return M
