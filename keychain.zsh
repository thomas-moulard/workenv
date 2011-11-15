# -*- shell-script -*-
if test -x /usr/bin/keychain; then
    keychain $KEYCHAIN_KEYS
    test -f "$HOME/.keychain/$HOST-sh" && source "$HOME/.keychain/$HOST-sh"
    test -f "$HOME/.keychain/$HOST-sh-gpg" && source "$HOME/.keychain/$HOST-sh-gpg"
fi
