local config = require('wezterm').config_builder()

require('options').config(config)

require('renderer').config(config)

require('theme').config(config)
require('fonts').config(config)

require('domains').config(config)

require('window').config(config)

require('status').config()
require('tabs').config(config)

require('panes').config(config)

require('keys').config(config)

return config
