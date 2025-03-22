local M = {}

local colors = require 'colors'
local pwsh = require('util').pwsh
local wezterm = require 'wezterm'

local ram, updated, last = 0, 0, ''

local function check(counter)
  return pwsh("(Get-Counter '" .. counter .. "').CounterSamples.CookedValue", function(stdout)
    local result = stdout:match('%d+%,?%d*'):gsub(',', '.')
    return tonumber(result)
  end, 0)
end

local function color(used, low, med, high)
  if used > high then
    return colors.term_red
  elseif used > med then
    return colors.term_orange
  elseif used > low then
    return colors.term_yellow
  end
  return colors.bg3
end

local function cpu()
  local used = check '\\Processor(_Total)\\% Processor Time'
  return string.format('%.1f', used) .. '%', color(used, 25, 50, 75)
end

local function mem()
  local free = check '\\Memory\\Available MBytes'
  local used = ((ram - free) / ram) * 100
  return string.format('%.1f', free / 1024) .. 'G', color(used, 50, 70, 90)
end

local function mem_total()
  return pwsh('(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory', function(stdout)
    return tonumber(stdout:match '%d+') / 1024 ^ 2
  end, 0)
end

function M.stats()
  if ram == 0 then
    ram = mem_total()
  end
  local now = os.time()
  if now - updated < 15 then
    return last
  end
  local cpu_used, cpu_color = cpu()
  local mem_free, mem_color = mem()
  updated = now
  last = wezterm.format { { Foreground = { Color = cpu_color } }, { Text = cpu_used .. ' ' } }
    .. wezterm.format { { Foreground = { Color = mem_color } }, { Text = mem_free .. ' ' } }
  return last
end

return M
