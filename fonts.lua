local M = {}

local wezterm = require 'wezterm'

function M.config(config)
  local font = {
    family = 'Cascadia Code NF',
    harfbuzz_features = { 'calt = 1', 'ss01 = 1' },
  }

  config.font = wezterm.font(font)
  config.font_size = 12.0

  -- don't use very thin strokes for dim fonts
  font.weight = 'DemiLight'
  config.font_rules = {
    {
      intensity = 'Half',
      font = wezterm.font(font),
    },
  }

  config.command_palette_font = wezterm.font 'Segoe UI'
  config.command_palette_font_size = 11.0

  config.char_select_font = wezterm.font 'Segoe UI'
  config.char_select_font_size = 11.0

  config.pane_select_font = wezterm.font 'Segoe UI'
  config.pane_select_font_size = 32.0

  config.strikethrough_position = '8pt'
  config.underline_position = '-1pt'
  config.underline_thickness = '1pt'

  config.text_blink_rate = 1000
  config.text_blink_rate_rapid = 500

  config.custom_block_glyphs = false

  config.default_cursor_style = 'SteadyBar'
  config.cursor_thickness = '1pt'
  config.cursor_blink_rate = 1000
end

return M