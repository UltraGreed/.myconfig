function dnif --description 'looks for dir with given name in all parent directories'
    set DIR $(pwd)/
    while not test -z "$DIR"; and not test -e "$DIR/$argv[1]"
        if test $DIR = '/'
            set DIR ''
        else
            set DIR $(string replace -r '/[^/]+/?$' '/' $DIR)
        end
    end
    echo "$DIR"
end

