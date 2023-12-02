local M = {}

function M.config(config)
  config.color_schemes = {
    ['Gruvbox Material Dark'] = {
      background = '#32302f',     -- bg0
      foreground = '#d4be98',     -- fg0

      cursor_bg = '#928374',      -- grey1
      cursor_fg = '#32302f',      -- bg0

      cursor_border = '#928374',  -- grey1
      compose_cursor = '#b47109', -- yellow

      selection_bg = '#d4be98',   -- fg0
      selection_fg = '#32302f',   -- bg0

      split = '#504945',          -- bg3

      ansi = {
        '#3c3836', -- bg1
        '#c14a4a', -- red
        '#6c782e', -- green
        '#b47109', -- yellow
        '#45707a', -- blue
        '#945e80', -- magenta
        '#4c7a5d', -- cyan
        '#928374', -- grey1
      },

      brights = {
        '#665c54', -- bg5
        '#ea6962', -- red
        '#a9b665', -- green
        '#d8a657', -- yellow
        '#7daea3', -- blue
        '#d3869b', -- magenta
        '#89b482', -- cyan
        '#d4be98', -- fg0
      },

      tab_bar = {
        background = 'rgba(50, 48, 47, 0)', -- bg0

        active_tab = {
          bg_color = 'rgba(50, 48, 47, 0)', -- bg0
          fg_color = '#665c54',             -- bg5
        },

        inactive_tab = {
          bg_color = 'rgba(50, 48, 47, 0)', -- bg0
          fg_color = '#504945',             -- bg3
        },

        inactive_tab_hover = {
          bg_color = 'rgba(50, 48, 47, 0)', -- bg0
          fg_color = '#928374',             -- grey1
        },

        new_tab = {
          bg_color = 'rgba(50, 48, 47, 0)', -- bg0
          fg_color = '#504945',             -- bg3
        },

        new_tab_hover = {
          bg_color = 'rgba(50, 48, 47, 0)', -- bg0
          fg_color = '#928374',             -- grey1
        },
      },
    },
  }

  config.color_scheme = 'Gruvbox Material Dark'

  local colors = config.color_schemes[config.color_scheme]

  config.command_palette_bg_color = colors.cursor_fg
  config.command_palette_fg_color = colors.foreground

  config.char_select_bg_color = colors.cursor_fg
  config.char_select_fg_color = colors.foreground

  config.colors = {
    copy_mode_active_highlight_bg = { Color = colors.ansi[4] },
    copy_mode_active_highlight_fg = { Color = colors.background },

    copy_mode_inactive_highlight_bg = { Color = colors.brights[4] },
    copy_mode_inactive_highlight_fg = { Color = colors.background },

    quick_select_label_bg = { Color = colors.ansi[4] },
    quick_select_label_fg = { Color = colors.background },

    quick_select_match_bg = { Color = colors.brights[4] },
    quick_select_match_fg = { Color = colors.background },
  }

  config.bold_brightens_ansi_colors = 'No'
end

return M