# -*- mode: sh -*-
###############################################################################
# Aliases
###############################################################################
# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g L='|less'

alias dbg='gdb --batch -x ~/.gdbrun --args'

# Ls
lsbin='ls'
case `uname -s` in
  *BSD | Darwin)
    gls --version >/dev/null 2>/dev/null && lsbin='gls' && \
      export LS_OPTIONS="$LS_OPTIONS -b -h --color"
    ;;
  Linux | CYGWIN*)
    export LS_OPTIONS="$LS_OPTIONS -b -h --color"
    ;;
esac
alias l="$lsbin $LS_OPTIONS"
alias ls="$lsbin $LS_OPTIONS"
alias ll="$lsbin $LS_OPTIONS -l"
alias la="$lsbin $LS_OPTIONS -la"
alias la="$lsbin $LS_OPTIONS -ld .*"

# Avoid dangerous spelling correction.
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history

# Other tools
alias e=emacs
alias m=make

function makeBuildDirectory
{
    mkdir -p _build/Release
    mkdir -p _build/Debug
    mkdir -p _build/clang+Release
    mkdir -p _build/clang+Debug

    COMMON_FLAGS="-DCMAKE_INSTALL_PREFIX=$piu"

    d=`pwd`
    cd $d/_build/Debug
    cmake -DCMAKE_BUILD_TYPE=Debug $COMMON_FLAGS ../..
    cd $d/_build/Release
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo $COMMON_FLAGS ../..
    cd $d/_build/clang+Debug
    CC=clang CXX=clang++ cmake -DCMAKE_BUILD_TYPE=Debug $COMMON_FLAGS ../..
    cd $d/_build/clang+Release
    CC=clang CXX=clang++ cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ../..
    cd $d
}

alias mb=makeBuildDirectory
