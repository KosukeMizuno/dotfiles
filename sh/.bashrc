#!/bin/bash
#### BASHRC ####

echo "Loading bashrc"

# Source global definitions
if [ -f /etc/bashrc ]; then
	source "/etc/bashrc"
fi

# alias
source "$DOTPATH/sh/alias.sh"

# terminal config
export USE_ICON_IN_TERM=true

# load local bashrc
if [ -f "$HOME/.bashrc_local" ]; then
	source "$HOME/.bashrc_local"
fi
