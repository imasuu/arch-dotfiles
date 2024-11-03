local wezterm = require 'wezterm'
local config = {}

config = {
  -- General settings
  enable_wayland = true,
  window_background_opacity = 0.7,
  front_end = 'WebGpu',
  webgpu_power_preference = 'HighPerformance',
  hide_tab_bar_if_only_one_tab = true,
}

return config
