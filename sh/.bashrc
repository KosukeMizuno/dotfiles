#### BASHRC ####
# shellcheck disable=SC1091,SC2148

# Source global definitions
if [ -f /etc/bashrc ]; then
    source "/etc/bashrc"
fi

# common
source "$DOTPATH/sh/common.sh"

# prompt
[[ -n $(command -v starship) ]] && eval "$(starship init bash)"

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [[ -e "$HOME/.shrc_local" ]]; then
    source "$HOME/.shrc_local"
fi
