local M = {}

local palette = require('palette').gruvbox_material_dark()
local monitor = require 'monitor'

local function mode(window, colors)
  if window:leader_is_active() then
    return '', colors.compose_cursor
  elseif window:composition_status() then
    return '󰬴', colors.compose_cursor
  end
  local key_table = window:active_key_table()
  if key_table == 'pane' then
    return '', colors.ansi[4]
  elseif key_table == 'resize' then
    return '󰁜', palette.term_orange
  elseif key_table == 'move' then
    return '󰁔', colors.ansi[2]
  elseif key_table == 'tab' then
    return '', colors.ansi[5]
  elseif key_table == 'mux' then
    return '󰣖', colors.ansi[6]
  elseif key_table == 'copy_mode' then
    return '󰁝', colors.ansi[3]
  elseif key_table == 'search_mode' then
    return '', colors.ansi[7]
  end
  return '󰞷', colors.tab_bar.active_tab.fg_color
end

function M.config(wezterm, config)
  local colors = config.color_schemes[config.color_scheme]

  wezterm.on('update-status', function(window, pane)
    local icon, color = mode(window, colors)
    window:set_left_status(wezterm.format {
      { Foreground = { Color = color } },
      { Text = ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.tab_bar.active_tab.bg_color } },
      { Background = { Color = color } },
      { Text = icon },
    } .. wezterm.format {
      { Foreground = { Color = color } },
      { Text = ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
      { Text = wezterm.mux.get_active_workspace() .. ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
      { Text = pane:get_domain_name() .. ' ' },
    })
    window:set_right_status(wezterm.format { { Text = monitor.cpu(wezterm) } })
  end)
end

return M