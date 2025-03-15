local M = {}

local function fg_color(tab, colors)
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

local function progress_icon(percentage)
  local icons = { '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥' }
  return icons[math.floor(percentage / 12) + 1]
end

local function progress(pane, colors)
  local icon, color = nil, colors.tab_bar.active_tab.fg_color
  if pane.progress then
    if pane.progress.Percentage ~= nil then
      icon = progress_icon(pane.progress.Percentage)
      color = colors.ansi[3]
    elseif pane.progress.Error ~= nil then
      icon = progress_icon(pane.progress.Error)
      color = colors.ansi[2]
    elseif pane.progress == 'Indeterminate' then
      icon = '󰪡'
      color = colors.ansi[5]
    end
  end
  return {
    { Foreground = { Color = color } },
    { Text = icon and icon .. ' ' or '' },
  }
end

function M.config(wezterm, config)
  local colors = config.color_schemes[config.color_scheme]

  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true

  config.tab_max_width = 64
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

  wezterm.on('format-tab-title', function(tab) -- tabs, panes, config, hover, max_width
    return wezterm.format {
      { Foreground = { Color = fg_color(tab, colors) } },
      {
        Text = string.format(
          '%s:%s %s ',
          tab.tab_index,
          tab.active_pane.pane_index,
          string.gsub(tab.active_pane.title, 'Copy mode: ', '')
        ),
      },
    } .. wezterm.format(progress(tab.active_pane, colors)) .. wezterm.format {
      { Foreground = { Color = fg_color(tab, colors) } },
      { Text = tab.active_pane.is_zoomed and ' ' or '' },
    }
  end)
end

return M
