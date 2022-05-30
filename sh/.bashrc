#### BASHRC ####
# shellcheck disable=SC1091,SC2148

# Source global definitions
if [ -f /etc/bashrc ]; then
    source "/etc/bashrc"
fi

# common
[ -n "$DOTPATH" ] && source "$DOTPATH/sh/common.sh"

# prompt
# Note: 重すぎるので、starhipはやめる... 代替を探したい
#[[ -n $(command -v starship) ]] && eval "$(starship init bash)"

# alias
[ -n "$DOTPATH" ] && source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [[ -e "$HOME/.shrc_local" ]]; then
    source "$HOME/.shrc_local"
fi
