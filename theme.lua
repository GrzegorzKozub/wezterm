local M = {}

local colors = require 'colors'

function M.config(config)
  config.color_schemes = {
    ['Gruvbox Material Dark'] = {
      background = colors.bg0,
      foreground = colors.fg0,

      cursor_bg = colors.grey1,
      cursor_fg = colors.bg0,

      cursor_border = colors.grey1,
      compose_cursor = colors.term_yellow,

      selection_bg = colors.bg3,
      selection_fg = 'none',

      ansi = {
        colors.term_black,
        colors.term_red,
        colors.term_green,
        colors.term_yellow,
        colors.term_blue,
        colors.term_purple,
        colors.term_aqua,
        colors.term_white,
      },

      brights = {
        colors.black,
        colors.red,
        colors.green,
        colors.yellow,
        colors.blue,
        colors.purple,
        colors.aqua,
        colors.white,
      },

      split = colors.bg1,

      tab_bar = {
        background = colors.none,

        active_tab = {
          bg_color = colors.none,
          fg_color = colors.bg5,
        },

        inactive_tab = {
          bg_color = colors.none,
          fg_color = colors.bg3,
        },

        inactive_tab_hover = {
          bg_color = colors.none,
          fg_color = colors.grey1,
        },

        new_tab = {
          bg_color = colors.none,
          fg_color = colors.bg5,
        },

        new_tab_hover = {
          bg_color = colors.none,
          fg_color = colors.grey1,
        },
      },
    },
  }

  config.color_scheme = 'Gruvbox Material Dark'

  config.command_palette_bg_color = colors.bg0
  config.command_palette_fg_color = colors.fg0

  config.char_select_bg_color = colors.bg0
  config.char_select_fg_color = colors.fg0

  config.pane_select_bg_color = colors.black
  config.pane_select_fg_color = colors.bg0

  config.colors = {
    copy_mode_active_highlight_bg = { Color = colors.term_yellow },
    copy_mode_active_highlight_fg = { Color = colors.bg0 },

    copy_mode_inactive_highlight_bg = { Color = colors.yellow },
    copy_mode_inactive_highlight_fg = { Color = colors.bg0 },

    quick_select_label_bg = { Color = colors.term_yellow },
    quick_select_label_fg = { Color = colors.bg0 },

    quick_select_match_bg = { Color = colors.yellow },
    quick_select_match_fg = { Color = colors.bg0 },

    input_selector_label_bg = { Color = colors.bg0 },
    input_selector_label_fg = { Color = colors.term_white },
  }

  config.bold_brightens_ansi_colors = 'No'
end

return M