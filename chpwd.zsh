###############################################################################
# Print path in term
###############################################################################
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
      sun-cmd) print -Pn "\e]l%n@%m %~\e\\"
        ;;
      *xterm*|rxvt|(k|E|dt)term) print -Pn "\e]0;%n@%m %~\a"
        ;;
    esac
}

chpwd
