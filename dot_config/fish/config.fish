# uv
fish_add_path "/home/raizo/.local/bin"

set -gx GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
