#### .PROFILE ####
# This file is sourced at starting Ubuntu-Desktop.
# shellcheck disable=SC2148,SC1091

export DOTPATH="${DOTPATH:-$HOME/dotfiles}"

if [ -e "$DOTPATH/sh/path.sh" ]; then
    source "$DOTPATH/sh/path.sh"
fi

if [ -e "$DOTPATH/sh/common.sh" ]; then
    source "$DOTPATH/sh/common.sh"
fi
