function tmuxpy --description 'Creates tmux setup with 3 panes, with venvs, ready to execute'
    set base_name "python session $(basename $PWD)"
    set counter 0
    while tmux has-session -t $base_name$counter 2> /dev/null
        set counter (math $counter + 1)
    end

    set session_name $base_name$counter

    if test -z $TMUX  # check if not inside tmux shell
        tmux new-session -d -s $session_name
    else
        tmux rename-session $session_name
    end

    tmux split-window -h  # Create right-side pane
    tmux split-window -v  # Split the right-side pane into two

    # Resize the first (left) pane to 100 characters wide
    # (I have no idea why, but sometimes sizing is not accurate by ~35 pixels)
    tmux resize-pane -t 0 -x 126

    for i in (seq 3)
        tmux send-keys -t (math $i - 1) 'venv' Enter
    end

    tmux send-keys -t 2 'python' Enter

    tmux selectp -t 0

    tmux send-keys -t 0 'vim .' Enter

    if test -z $TMUX
        tmux attach-session -t $session_name
    end
end
