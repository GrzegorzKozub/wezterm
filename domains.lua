local M = {}

function M.config(config)
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.ssh_domains = {}
  config.unix_domains = {
    {
      name = 'unix',
      serve_command = { 'wezterm-mux-server', '--daemonize', 'pwsh.exe', '-NoLogo' },
      skip_permissions_check = true,
    },
  }

  -- seems this works as well as the one below
  config.default_domain = 'unix'
  -- config.default_gui_startup_args = { 'connect', 'unix', 'pwsh.exe', '-NoLogo' }
end

return M