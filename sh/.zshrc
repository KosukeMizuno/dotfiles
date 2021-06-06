#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
#${ZDOTDIR:-$HOME}/.zprezto ❯❯❯ cat ~/.zshrc
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...


#### ZSHRC ####

# common
source "$DOTPATH/sh/common.sh"

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [ -f "$HOME/.shrc_local" ]; then
	source "$HOME/.shrc_local"
fi

#### PROFILING ####
# zshenv の最初にあるzprofも併せて有効化する必要がある
if [ -n "${ZSH_DO_PROFILING:-}" ]; then
    if (which zprof > /dev/null 2>&1) ; then
        zprof
    fi
fi

# vim: set ft=sh :