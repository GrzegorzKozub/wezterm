local M = {}

local function adjust(window, config, delta)
  local overrides = window:get_config_overrides() or {}
  local opacity = overrides.window_background_opacity or nil
  if not opacity then
    opacity = config.window_background_opacity + delta
  else
    opacity = opacity + delta
  end
  if opacity >= 0 and opacity <= 1 then
    overrides.window_background_opacity = opacity
    window:set_config_overrides(overrides)
  end
end

function M.decrease(window, config)
  adjust(window, config, -0.05)
end

function M.increase(window, config)
  adjust(window, config, 0.05)
end

return M