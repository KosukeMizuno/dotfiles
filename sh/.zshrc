#### ZSHRC: Setup prezto & p10k ####

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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