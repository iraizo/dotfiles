local wezterm = require("wezterm") ---@type Wezterm
local agent_deck = wezterm.plugin.require("https://github.com/Eric162/wezterm-agent-deck")
local config = wezterm.config_builder()
local ui = require("ui")
local keys = require("keys")
local ssh = require("ssh")

agent_deck.apply_to_config(config)
ui.apply(config, wezterm)
ssh.apply(config)
config.keys = keys.build(wezterm)

return config
