# -*- shell-script -*-

IDENTIY_FILE="$HOME/.identity.zsh"

if ! test -f "$IDENTIY_FILE"; then
 echo "failed to load identity file"
 echo "please run cp ~/.workenv/.identity.zsh.example ~/.identity.zsh"
 return 42
fi

# Clean environment variables.
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export LD_LIBRARY_PATH=""
export PYTHON_PATH=""
export PKG_CONFIG_PATH=""

test -f "/etc/profile" && source "/etc/profile"

source "$IDENTIY_FILE"

if test x"$WORKENV_DIR" = x; then
 echo "WORKENV_DIR variable is missing in the identity file"
 return 42
fi

source "$WORKENV_DIR/var.zsh"
source "$WORKENV_DIR/colors.zsh"
source "$WORKENV_DIR/aliases.zsh"
source "$WORKENV_DIR/bindkey.zsh"
source "$WORKENV_DIR/chpwd.zsh"
source "$WORKENV_DIR/completion.zsh"
source "$WORKENV_DIR/hrp2.zsh"
source "$WORKENV_DIR/ros.zsh"
source "$WORKENV_DIR/misc.zsh"
source "$WORKENV_DIR/options.zsh"
source "$WORKENV_DIR/self-update.zsh"

source "$WORKENV_DIR/keychain.zsh"

source "$WORKENV_DIR/profiles.zsh"

source "$WORKENV_DIR/prompt.zsh"
