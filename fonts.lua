local M = {}

function M.config(wezterm, config)
  config.font = wezterm.font {
    family = 'CaskaydiaCove Nerd Font',
    harfbuzz_features = { 'calt = 1', 'ss01 = 1' },
  }

  config.font_size = 12.0
  config.command_palette_font_size = 12.0
  config.char_select_font_size = 12.0
end

return M