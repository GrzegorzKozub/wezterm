local M = {}

function M.config(config)
  config.color_schemes = {
    ['Gruvbox Material Dark'] = {
      background = '#32302f', -- bg0
      foreground = '#d4be98', -- fg0

      cursor_bg = '#928374', -- grey1
      cursor_fg = '#32302f', -- bg0

      cursor_border = '#928374', -- grey1
      compose_cursor = '#b47109', -- term_yellow

      selection_bg = '#504945', -- bg3
      selection_fg = 'none',

      ansi = {
        '#3c3836', -- bg1
        '#c14a4a', -- term_red
        '#6c782e', -- term_green
        '#b47109', -- term_yellow
        '#45707a', -- term_blue
        '#945e80', -- term_purple
        '#4c7a5d', -- term_aqua
        '#928374', -- grey1
      },

      brights = {
        '#665c54', -- bg5
        '#ea6962', -- red
        '#a9b665', -- green
        '#d8a657', -- yellow
        '#7daea3', -- blue
        '#d3869b', -- purple
        '#89b482', -- aqua
        '#d4be98', -- fg0
      },

      split = '#3c3836', -- bg1

      tab_bar = {
        background = 'rgba(0, 0, 0, 0)',

        active_tab = {
          bg_color = 'rgba(0, 0, 0, 0)',
          fg_color = '#665c54', -- bg5
        },

        inactive_tab = {
          bg_color = 'rgba(0, 0, 0, 0)',
          fg_color = '#504945', -- bg3
        },

        inactive_tab_hover = {
          bg_color = 'rgba(0, 0, 0, 0)',
          fg_color = '#928374', -- grey1
        },

        new_tab = {
          bg_color = 'rgba(0, 0, 0, 0)',
          fg_color = '#665c54', -- bg5
        },

        new_tab_hover = {
          bg_color = 'rgba(0, 0, 0, 0)',
          fg_color = '#928374', -- grey1
        },
      },
    },
  }

  config.color_scheme = 'Gruvbox Material Dark'

  local colors = config.color_schemes[config.color_scheme]

  config.command_palette_bg_color = colors.background
  config.command_palette_fg_color = colors.foreground

  config.char_select_bg_color = colors.background
  config.char_select_fg_color = colors.foreground

  config.pane_select_bg_color = colors.brights[1]
  config.pane_select_fg_color = colors.background

  config.colors = {
    copy_mode_active_highlight_bg = { Color = colors.ansi[4] },
    copy_mode_active_highlight_fg = { Color = colors.background },

    copy_mode_inactive_highlight_bg = { Color = colors.brights[4] },
    copy_mode_inactive_highlight_fg = { Color = colors.background },

    quick_select_label_bg = { Color = colors.ansi[4] },
    quick_select_label_fg = { Color = colors.background },

    quick_select_match_bg = { Color = colors.brights[4] },
    quick_select_match_fg = { Color = colors.background },

    input_selector_label_bg = { Color = colors.background },
    input_selector_label_fg = { Color = colors.ansi[8] },
  }

  config.bold_brightens_ansi_colors = 'No'
end

return M
