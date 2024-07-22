-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- Startup full size
wezterm.on("gui-startup", function(window)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:maximize()
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "tokyonight_night"
config.font_size = 18.0
config.native_macos_fullscreen_mode = true
config.font = wezterm.font("JetBrains Mono", { italic = false })

-- Disable ligatures
config.harfbuzz_features = { "calt=0" }

-- and finally, return the configuration to wezterm
return config
