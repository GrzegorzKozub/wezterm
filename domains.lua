local M = {}

-- todo: https://wezterm.org/multiplexing.html https://wezterm.org/recipes/workspaces.html

function M.config(config)
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.ssh_domains = {}
end

return M