#### BASHRC ####
# shellcheck disable=SC1091,SC2148

# do nothing if rsh
# NOTE: This return should be at the top of `~/.bashrc`
#       https://superuser.com/questions/1685376/how-to-distinguish-between-rsync-and-ssh-access-in-a-bashrc-script
[[ $- == *i* ]] || return 0

# Source global definitions
if [ -f /etc/bashrc ]; then
    source "/etc/bashrc"
fi

# common
source "$DOTPATH/sh/common.sh"

# prompt
# Note: 重すぎるので、starhipはやめる... 代替を探したい
#[[ -n $(command -v starship) ]] && eval "$(starship init bash)"

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [[ -e "$HOME/.shrc_local" ]]; then
    source "$HOME/.shrc_local"
fi
