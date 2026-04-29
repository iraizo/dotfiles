local M = {}

function M.build(wezterm)
	local act = wezterm.action

	return {
		{ key = "raw:66", mods = "ALT", action = act.PaneSelect },
		{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "ALT", action = act.ActivateTabRelative(1) },
		{ key = "w", mods = "ALT|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },
		{ key = "v", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "ALT|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "LeftArrow", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1) },
	}
end

return M
