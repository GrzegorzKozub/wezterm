local M = {}

function M.config(config)
  config.automatically_reload_config = false
  config.command_palette_rows = 16
  config.check_for_updates = false
end

return M
