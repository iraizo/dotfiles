local M = {}

function M.apply(config, wezterm)
	local font = wezterm.font("Iosevka Nerd Font Mono")

	config.colors = require("ashen")
	config.use_fancy_tab_bar = false
	config.window_decorations = "NONE"
	config.hide_tab_bar_if_only_one_tab = true
	config.kde_window_background_blur = true
	config.font_size = 16
	config.font = font
	config.line_height = 1.0
	config.max_fps = 144
	config.window_padding = {
		left = 5,
		right = 0,
		top = 5,
		bottom = 0,
	}
	config.window_frame = {
		font = font,
	}
	config.quick_select_alphabet = "arstqwfpzxcvneioluymdhgjbk"
end

return M
