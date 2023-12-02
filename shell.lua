local M = {}

function M.config(config)
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.audible_bell = 'Disabled'
end

return M