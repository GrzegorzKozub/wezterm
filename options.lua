local M = {}

function M.config(config)
  config.automatically_reload_config = false
  config.check_for_updates = false
  config.command_palette_rows = 16
end

return M