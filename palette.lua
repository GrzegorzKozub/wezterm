local M = {}

local function gruvbox_material_dark()
  return {
    bg1 = '#3c3836',
    bg3 = '#504945',

    grey1 = '#928374',

    term_red = '#c14a4a',
    term_green = '#6c782e',
    term_yellow = '#b47109',
    term_blue = '#45707a',
    term_purple = '#945e80',
    term_aqua = '#4c7a5d',
    term_orange = '#c35e0a',
  }
end

function M.get()
  return gruvbox_material_dark()
end

return M
