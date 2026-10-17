local M = {}

local pwsh = require('util').pwsh
local wezterm = require 'wezterm'

local admin, checked = false, false

local function check_admin()
  return pwsh("[Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544'", function(stdout)
    return stdout:match 'True' and true or false
  end, false)
end

wezterm.on('update-status', function() -- window, pane
  if not checked then
    checked = true
    admin = check_admin()
  end
end)

function M.admin()
  return admin
end

return M