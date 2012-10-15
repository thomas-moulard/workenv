###############################################################################
# Prompts
###############################################################################
# secondary prompt, printed when the shell needs more information to
# complete a command.
PS2='`%_> '
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i>'
PS4='+%N:%i:%_> '
if [ $UID != 0 ]; then
  local prompt_user="${lgreen}%n${std}"
else
  local prompt_user="${lred}%n${std}"
fi
local prompt_host="${lyellow}%m${std}"
local prompt_cwd="%B%40<..<%~%<<%b"
local prompt_time="${lblue}%D{%H:%M:%S}${std}"
local prompt_rv="%(?..${lred}%?${std} )"
if [ `which rosversion` ]; then
    local prompt_rosversion=`rosversion -d`
else
    local prompt_rosversion="N/A"
fi
PROMPT="${prompt_user}${lwhite}@${std}${prompt_host}<$PROFILE> ${prompt_cwd} %(!.#.$) "
RPROMPT="${prompt_rv}${prompt_time} ${lgreen}${prompt_rosversion}${std}"
