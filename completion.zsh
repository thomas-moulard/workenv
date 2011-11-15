# -*- shell-script -*-
###############################################################################
# Completion
###############################################################################
# Setup new style completion system.
autoload -U compinit
compinit

zmodload zsh/complist

# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'
# format on completion
zstyle ':completion:*:descriptions' format \
       $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
# provide verbose completion information
zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format \
       $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
# separate matches into groups
zstyle ':completion:*:matches' group 'yes'
# describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'

# activate color-completion(!)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## correction

# Ignore completion functions for commands you don't have:
#  zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

zstyle ':completion:*'             completer _complete _correct _approximate
zstyle ':completion:*:correct:*'   insert-unambiguous true
#  zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
#  zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:corrections' format \
	$'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'   original true
zstyle ':completion:correct:'      prompt 'correct to:'

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:' max-errors \
	'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
#  zstyle ':completion:*:correct:*'   max-errors 2 numeric

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# ignore duplicate entries
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns  \
	'*?.(o|c~|old|pro|zwc)' '*~'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# If there are more than N options, allow selecting from a menu with
# arrows (case insensitive completion!).
#  zstyle ':completion:*-case' menu select=5
zstyle ':completion:*' menu select=2

# caching
[ -d $ZSHDIR/cache ] && zstyle ':completion:*' use-cache yes && \
                        zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/

# use ~/.ssh/known_hosts for completion
#  local _myhosts
#  _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
#  zstyle ':completion:*' hosts $_myhosts
known_hosts=''
[ -f "$HOME/.ssh/known_hosts" ] && \
known_hosts="`awk '$1!~/\|/{print $1}' $HOME/.ssh/known_hosts | cut -f1 -d, | xargs`"

zstyle ':completion:*:hosts' hosts ${=known_hosts}

# simple completion for fbset (switch resolution on console)
_fbmodes() { compadd 640x480-60 640x480-72 640x480-75 640x480-90	\
640x480-100 768x576-75 800x600-48-lace 800x600-56 800x600-60		\
800x600-70 800x600-72 800x600-75 800x600-90 800x600-100			\
1024x768-43-lace 1024x768-60 1024x768-70 1024x768-72 1024x768-75	\
1024x768-90 1024x768-100 1152x864-43-lace 1152x864-47-lace 1152x864-60	\
1152x864-70 1152x864-75 1152x864-80 1280x960-75-8 1280x960-75		\
1280x960-75-32 1280x1024-43-lace 1280x1024-47-lace 1280x1024-60		\
1280x1024-70 1280x1024-74 1280x1024-75 1600x1200-60 1600x1200-66	\
1600x1200-76 }
compdef _fbmodes fbset

# use generic completion system for programs not yet defined:
compdef _gnu_generic tail head feh cp mv gpg df stow uname ipacsum fetchipac

# Debian specific stuff
zstyle ':completion:*:*:linda:*'   file-patterns '*.deb'

_debian_rules() { words=(make -f debian/rules) _make }
compdef _debian_rules debian/rules
# type debian/rules <TAB> inside a source package

# see upgrade function in this file
compdef _hosts upgrade
