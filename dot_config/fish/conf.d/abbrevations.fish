if status is-interactive
    alias cd='z'
    alias cat='bat -pp'
    alias less='bat'

    alias ls "eza -l -a --group-directories-first --smart-group -M --time-style='+%d.%m.%y %H:%M' --time=modified --git"
    alias la "eza -l -a --group-directories-first --smart-group -M --time-style='+%d.%m.%y %H:%M' --time=modified --git"
    alias lt "eza -l -a --group-directories-first --smart-group -M -s modified --time-style='+%d.%m.%y %H:%M' --time=modified --git"

    abbr --add --global grep rg
    abbr --add --global find fd
    abbr --add --global wt wezterm
    abbr --add --global wtssh wezterm ssh
    abbr --add --global port 'lsof -i'
end
