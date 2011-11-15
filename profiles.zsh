# Development profile management.
CONFIG_SH="$HOME/profiles/$PROFILE/config.sh"
test -f "$CONFIG_SH" && source "$CONFIG_SH" || echo "failed to load profile $PROFILE"
