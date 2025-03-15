local M = {}

function M.config(config)
  local concat = require('util').concat

  config.default_prog = { 'pwsh', '-NoLogo' }

  config.ssh_domains = {}
  config.unix_domains = {
    {
      name = 'unix',
      serve_command = concat({ 'wezterm-mux-server', '--daemonize' }, config.default_prog),
      skip_permissions_check = true,
    },
  }

  -- config.default_domain = 'unix'
  -- config.default_gui_startup_args = concat({ 'connect', 'unix' }, config.default_prog)
end

return M
