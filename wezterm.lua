local wezterm = require 'wezterm'
local config = wezterm.config_builder()

require('renderer').config(config)

require('shell').config(config)

require('colors').config(config)
require('fonts').config(wezterm, config)

require('window').config(wezterm, config)
require('tabs').config(wezterm, config)
require('panes').config(config)

require('keys').config(wezterm, config)

require('updates').config(config)

return config