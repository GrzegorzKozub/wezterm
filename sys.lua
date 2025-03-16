local M = {}

local wezterm = require 'wezterm'
local palette = require('palette').get()

local ram, updated, last = 0, 0, ''

local function check(counter)
  local ok, stdout = wezterm.run_child_process { 'pwsh', '-Command', counter }
  if ok then
    local result = stdout:match('%d+%,?%d*'):gsub(',', '.')
    return tonumber(result)
  else
    return 0
  end
end

local function color(used, low, med, high)
  if used > high then
    return palette.term_red
  elseif used > med then
    return palette.term_orange
  elseif used > low then
    return palette.term_yellow
  end
  return palette.bg3
end

local function cpu()
  local used = check "(Get-Counter '\\Processor(_Total)\\% Processor Time').CounterSamples.CookedValue"
  return string.format('%.1f', used) .. '%', color(used, 25, 50, 75)
end

local function mem()
  local free = check "(Get-Counter '\\Memory\\Available MBytes').CounterSamples.CookedValue"
  local used = ((ram - free) / ram) * 100
  return string.format('%.1f', free / 1024) .. 'G', color(used, 50, 70, 90)
end

local function mem_total()
  local ok, stdout = wezterm.run_child_process { 'wmic', 'ComputerSystem', 'get', 'TotalPhysicalMemory' }
  if ok then
    return tonumber(stdout:match '%d+') / 1024 ^ 2
  else
    return 0
  end
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
