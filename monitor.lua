local M = {}

local last_update_time = 0
local last_result = ''

function M.cpu(wezterm)
  local cpu_usage = '?'
  local current_time = os.time()
  if current_time - last_update_time < 15 then
    return last_result
  end
  local success, stdout = wezterm.run_child_process {
    'pwsh',
    '-Command',
    "(Get-Counter '\\Processor(_Total)\\% Processor Time').CounterSamples.CookedValue",
  }

  if success then
    local usage = stdout:match '%d+%.?%d*'
    if usage then
      cpu_usage = string.format('%.1f', tonumber(usage)) .. '%'
    end
  end

  last_update_time = current_time
  last_result = cpu_usage

  return tostring(cpu_usage)
end

return M

-- (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
