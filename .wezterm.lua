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

-- For example, changing the color scheme:
config.color_scheme = "tokyonight"
config.font_size = 18.0
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = false
config.font = wezterm.font("JetBrains Mono", { italic = false })

-- Disable ligatures
config.harfbuzz_features = { "calt=0" }

--Disable the tab bar
config.enable_tab_bar = true

-- and finally, return the configuration to wezterm
return config
