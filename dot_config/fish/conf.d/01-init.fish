if status is-interactive
    if not set -q ISTERM
        zoxide init fish | source
        starship init fish | source
        atuin init fish | source
        direnv hook fish | source
    end

    if not set -q ISTERM
        # Export fish_bind_mode so starship custom modules can read vi mode
        function __export_fish_bind_mode --on-variable fish_bind_mode
            set -gx FISH_BIND_MODE $fish_bind_mode
        end
        set -gx FISH_BIND_MODE $fish_bind_mode

        set -U fish_greeting
    end
end
