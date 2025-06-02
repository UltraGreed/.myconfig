function sudo --description 'use sudo -E by default; reminder to use su -m instead of sudo su'
    if test "$argv" = "su"
        echo 'Use "su -m" instead to preserve env. If sudo su still desired, use "command sudo su"'
        return 1
    end
    command sudo -E $argv
end
