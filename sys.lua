local M = {}

local last_update_time = 0
local last_result = ''

function M.stats(wezterm, colors)
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
      cpu_usage = string.format('%.1f', tonumber(usage)) .. '% 0.0G'
    end
  end

  last_update_time = current_time
  last_result = wezterm.format {
    { Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
    { Text = cpu_usage .. ' ' },
  }

  return last_result
end

return M

-- (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue