local M = {}

function M.config(config)
  config.front_end = 'OpenGL' -- slow startup with WebGpu
  config.max_fps = 120
end

return M