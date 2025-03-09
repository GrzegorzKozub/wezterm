local M = {}

function M.config(wezterm, config)
  local colors = config.color_schemes[config.color_scheme]

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
      { Foreground = { Color = colors.ansi[2] } },
      { Text = close },
    },
  }

  wezterm.on('update-status', function(window, pane)
    local color = colors.tab_bar.active_tab.fg_color
    for _, item in ipairs(window:active_tab():panes_with_info()) do
      if item.is_active and item.is_zoomed then
        color = colors.ansi[6]
      end
    end
    if window:composition_status() or window:leader_is_active() then
      color = colors.compose_cursor
    end
    local kt = ''
    if window:active_key_table() then
      kt = window:active_key_table() .. ' '
      color = colors.ansi[3]
    end

    window:set_left_status(wezterm.format {
      { Foreground = { Color = color } },
      { Background = { Color = colors.tab_bar.background } },
      { Text = ' ●• ' .. kt },
    } .. wezterm.format {
      { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
      { Background = { Color = colors.tab_bar.background } },
      { Text = pane:get_domain_name() .. ' ' },
    } .. wezterm.format {
      { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
      { Background = { Color = colors.tab_bar.background } },
      { Text = window:active_tab():tab_id() .. ':' .. pane:pane_id() .. ' ' },
    })
  end)

  wezterm.on('format-tab-title', function(tab) -- tabs, panes, config, hover, max_width
    -- todo: https://wezterm.org/config/lua/pane/get_progress.html
    local color = colors.tab_bar.inactive_tab.fg_color
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        color = colors.tab_bar.active_tab.fg_color
        break
      end
    end
    return {
      { Foreground = { Color = color } },
      {
        Text = string.format(
          '%s:%s %s%s ',
          tab.tab_index,
          tab.active_pane.pane_index,
          string.gsub(tab.active_pane.title, 'Copy mode: ', ''),
          tab.active_pane.is_zoomed and ' ' or ''
        ),
      },
    }
  end)
end

return M
