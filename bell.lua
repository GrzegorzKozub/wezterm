local M = {}

-- test with echo `a

local wezterm = require 'wezterm'

local bells = {}

local function rung(tab)
  if not bells[tab] then
    bells[tab] = true
  end
end

function M.check(tab)
  return bells[tab]
end

function M.clear(tab)
  if bells[tab] then
    bells[tab] = nil
  end
end

function M.config(config)
  config.audible_bell = 'Disabled'

  wezterm.on('bell', function(window, pane)
    local active_tab, bell_tab = window:active_tab():tab_id(), pane:tab():tab_id()
    if active_tab ~= bell_tab then
      rung(bell_tab)
    end
  end)
end

return M
