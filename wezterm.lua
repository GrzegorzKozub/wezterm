local config = require('wezterm').config_builder()

require('options').config(config)

require('renderer').config(config)

require('theme').config(config)
require('fonts').config(config)

require('status').config()

require('keys').config(config)

require('mux').config(config)
require('windows').config(config)
require('tabs').config(config)
require('panes').config(config)
require('copy').config(config)
require('move').config(config)
require('resize').config(config)

return config