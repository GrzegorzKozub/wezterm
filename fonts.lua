local M = {}

function M.config(wezterm, config)
  local font = {
    family = 'Cascadia Code NF',
    harfbuzz_features = { 'calt = 1', 'ss01 = 1' },
  }
  config.font = wezterm.font(font)

  font.weight = 'DemiLight'
  config.font_rules = {
    {
      intensity = 'Half',
      italic = false,
      font = wezterm.font(font),
    },
  }

  config.font_size = 14.0
  config.command_palette_font_size = 14.0
  config.char_select_font_size = 14.0
end

return M
