local M = {}

-- todo: https://wezterm.org/recipes/workspaces.html

function M.config(config)
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.ssh_domains = {}

  -- config.quit_when_all_windows_are_closed = false
  -- config.unix_domains = {
  --   {
  --     name = 'unix1',
  --     serve_command = { 'wezterm-mux-server' },
  --   },
  -- }
  -- config.default_mux_server_domain = 'unix1'
  -- config.default_gui_startup_args = { 'connect', 'unix1' }
end

return M
