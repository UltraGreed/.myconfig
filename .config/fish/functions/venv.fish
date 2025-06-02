function venv
    if not test -z $VIRTUAL_ENV
        echo "Virtual environment already active - nothing to do."
        return
    end

    set venv_path (dnif ".venv")

    if not test -z $venv_path
        source $venv_path.venv/bin/activate.fish
        echo "Activated virtual environment at $venv_path.venv"
    else
        echo "Virtual environment .venv directory not found"
    end
end
