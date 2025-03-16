local M = {}

local colors = require 'colors'
local wezterm = require 'wezterm'

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
    { Text = icon and icon .. ' ' or '' },
  }
end

function M.config(config)
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
      { Foreground = { Color = colors.term_red } },
      { Text = close },
    },
  }

  wezterm.on('format-tab-title', function(tab) -- tabs, panes, config, hover, max_width
    return wezterm.format {
      { Foreground = { Color = fg_color(tab) } },
      {
        Text = string.format(
          '%s:%s %s ',
          tab.tab_index,
          tab.active_pane.pane_index,
          string.gsub(tab.active_pane.title, 'Copy mode: ', '')
        ),
      },
    } .. wezterm.format(progress(tab.active_pane)) .. wezterm.format {
      { Foreground = { Color = fg_color(tab) } },
      { Text = tab.active_pane.is_zoomed and ' ' or '' },
    }
  end)
end

return M
