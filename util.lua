local M = {}

local wezterm = require 'wezterm'

function M.concat(a, b)
  for _, val in ipairs(b) do
    table.insert(a, val)
  end
  return a
end

function M.pwsh(cmd, extract, fallback)
  local ok, stdout = wezterm.run_child_process { 'pwsh', '-Command', cmd }
  return ok and extract(stdout) or fallback
end

return M
