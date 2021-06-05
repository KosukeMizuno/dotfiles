#### BASHRC ####

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [ -f "$HOME/.bashrc_local" ]; then
	source "$HOME/.bashrc_local"
fi
