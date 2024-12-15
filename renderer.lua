local M = {}

function M.config(config)
  config.front_end = 'WebGpu'
  config.max_fps = 120
end

return M