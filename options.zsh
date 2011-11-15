###############################################################################
# Zsh options
###############################################################################
# spelling correction
setopt correct
# not just at the end
setopt complete_in_word
# when completing within a word, move cursor to the end of the word
setopt alwaystoend
# change to dirs without cd
setopt auto_cd
# If a new command added to the history list duplicates an older one,
#  the older is removed from the list
setopt hist_ignore_all_dups
# do not display duplicates when searching for history entries
setopt hist_find_no_dups
# Automatically list choices on an ambiguous completion.
setopt auto_list
# Automatically remove undesirable characters added after auto
# completions when necessary
setopt auto_param_keys
# Add slashes at the end of auto completed dir names
setopt auto_param_slash
# activates: ^x         Matches anything except the pattern x.
#            x~y        Match anything that matches the pattern x but does
#			not match y.
#            x#         Matches zero or more occurrences of the pattern x.
#            x##        Matches one or more occurrences of the pattern x.
setopt extended_glob
# Note the location of each command the first time it is executed in
# order to avoid search during subsequent invocations
setopt hash_cmds
# Whenever a command name is hashed, hash the directory containing it
setopt hash_dirs
# Print a warning message if a mail file has been accessed since the
# shell last checked.
setopt mail_warning
# append history list to the history file (important for multiple
# parallel zshsessions!)
setopt append_history
# imports new commands from the history file, causes your typed
# commands to be appended to the history file
setopt share_history

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
