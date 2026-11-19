local M = {}

-- workaround claude repainting on focus-out which flags tabs as having unseen output

local wezterm = require 'wezterm'

local snapshots = {} -- pane_id -> screen text, or true once it changed

local function text(pane_id)
  local pane = wezterm.mux.get_pane(pane_id)
  return pane and pane:get_lines_as_text() or ''
end

function M.check(tab)
  local result = false
  for _, pane in ipairs(tab.panes) do
    local id = pane.pane_id
    if tab.is_active then
      snapshots[id] = nil
    else
      snapshots[id] = snapshots[id] or text(id)
      if snapshots[id] ~= true and pane.has_unseen_output and text(id) ~= snapshots[id] then
        snapshots[id] = true
      end
      result = result or snapshots[id] == true
    end
  end
  return result
end

return M
