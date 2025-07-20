-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 16

config.font = wezterm.font('VictorMono Nerd Font Mono')
-- config.font_rules = {
--     {
--         intensity = 'Bold',
--         font = wezterm.font('VictorMono Nerd Font Mono', { weight = 'Bold'})
--     }
-- }

config.hide_tab_bar_if_only_one_tab = true

config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

config.window_close_confirmation = "NeverPrompt"

-- config.color_scheme = 'Azu (Gogh)'
-- config.color_scheme = 'Base4Tone Classic D (Gogh)'
config.color_scheme = 'Brogrammer (Gogh)'
-- config.color_scheme = 'Dark Pastel (Gogh)'
-- config.color_scheme = 'Catppuccin Mocha (Gogh)'

-- Finally, return the configuration to wezterm:
return config
