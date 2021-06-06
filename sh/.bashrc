#!/bin/bash
#### BASHRC ####

# Source global definitions
if [ -f /etc/bashrc ]; then
	source "/etc/bashrc"
fi

# common
source "$DOTPATH/sh/common.sh"

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [ -f "$HOME/.shrc_local" ]; then
	source "$HOME/.shrc_local"
fi
