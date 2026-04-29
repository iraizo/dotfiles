local M = {}

local ssh_auth_sock = "/home/raizo/.ssh/ssh_auth_sock"
local yubikey_pub = "/home/raizo/.ssh/yubikey_ed25519.pub"

local smartcard_ssh_option = {
	identityagent = ssh_auth_sock,
	identityfile = yubikey_pub,
	identitiesonly = "yes",
	forwardagent = "yes",
}

function M.apply(config)
	config.ssh_backend = "LibSsh"
	config.default_ssh_auth_sock = ssh_auth_sock
	config.mux_enable_ssh_agent = true

	config.unix_domains = {
		{
			name = "unix",
		},
	}

	config.default_gui_startup_args = { "connect", "unix" }

	config.ssh_domains = {
		{
			name = "root",
			remote_address = "root",
			username = "raizo",
			multiplexing = "WezTerm",
			local_echo_threshold_ms = 50000,
			assume_shell = "Posix",
			ssh_option = smartcard_ssh_option,
		},
		{
			name = "vps",
			remote_address = "vps",
			username = "raizo",
			multiplexing = "WezTerm",
			local_echo_threshold_ms = 50000,
			assume_shell = "Posix",
			ssh_option = smartcard_ssh_option,
		},
	}
end

return M
