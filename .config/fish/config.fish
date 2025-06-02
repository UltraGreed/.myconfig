if status is-interactive
    # ALIASES
    # Using trash instead of rm
    alias rm='echo "Use trash-put instead. If you truly intended to use rm, use command rm. "; false'

    # Using fast rust implementations of default linux apps
    alias grep='echo "Use rg instead. If you truly intended to use grep, use command grep. "; false'
    alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
    alias find=fd
end
