set fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here
end

export DISPLAY=:0.0
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
export DIRENV_LOG_FORMAT=
starship init fish | source
direnv hook fish | source
