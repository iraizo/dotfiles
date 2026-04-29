if status is-interactive
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c) >/dev/null
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        ssh-add ~/.ssh/yubikey_ed25519.pub
    end
end
