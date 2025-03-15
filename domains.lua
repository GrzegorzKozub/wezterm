local M = {}

function M.config(config)
  config.default_prog = { 'pwsh', '-NoLogo' }
  config.ssh_domains = {}
  config.unix_domains = {
    {
      name = 'unix',
      serve_command = { 'wezterm-mux-server', '--daemonize', 'pwsh', '-NoLogo' },
      skip_permissions_check = true,
    },
  }
  -- config.default_domain = 'unix'
  -- config.default_gui_startup_args = { 'connect', 'unix', 'pwsh', '-NoLogo' }
end

return M