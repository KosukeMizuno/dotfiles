#!/bin/bash
#### BASH_PROFILE ####

echo "Loading bash_profile"

# dotfiles
export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
source "$DOTPATH/sh/path.sh"

# load local bash_profile if exists
if [ -f "$HOME/.bash_profile_local" ]; then
    source "$HOME/.bash_profile_local"
fi

# load secure things if exists
if [ -f "$HOME/.sh_secure" ]; then
    source "$HOME/.sh_secure"
fi

# load bashrc
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# enable completion
# TODO: 遅いのでlazyloadingさせる
source "$DOTPATH/sh/completion.sh"
