local M = {}

local function mode(window, colors)
  -- todo: different icon for composition/leader
  if window:composition_status() or window:leader_is_active() then
    return '', colors.compose_cursor
  end
  local key_table = window:active_key_table()
  if key_table == 'pane' then
    return '', colors.ansi[4]
  end
  return '󰞷', colors.tab_bar.active_tab.fg_color
end

local function tab_color(tab, colors)
  if tab.is_active then
    return colors.tab_bar.active_tab.fg_color
  else
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        return colors.ansi[8]
      end
    end
    return colors.tab_bar.inactive_tab.fg_color
  end
end

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
      { Text = pane:get_domain_name() .. ' ' },
    })
  end)

  wezterm.on('format-tab-title', function(tab) -- tabs, panes, config, hover, max_width
    -- todo: https://wezterm.org/config/lua/pane/get_progress.html
    return {
      { Foreground = { Color = tab_color(tab, colors) } },
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