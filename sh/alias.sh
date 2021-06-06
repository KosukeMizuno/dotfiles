#!/bin/bash
#### rc.alias.sh ####
# define aliases

#### COMMAND LINE HELPER
# reload rc
alias rc='source $HOME/.bashrc'
alias rc_profile='source $HOME/.bash_profile'

# PATHを一覧で出す
function echo_path(){
    echo "$PATH" | tr ':' '\n'
}

# alias for mintty (winpty, encoding)
if [ "$TERM_PROGRAM" = "mintty" ]; then
    for name in node ipython python jupyter nvim; do
        alias $name="winpty $name"
    done

    for name in ipconfig; do
        alias $name="wincmd $name"
    done
fi

# encoding conversion for win
function wincmd()
{
    CMD=$1
    shift
    $CMD "$@" 2>&1 | iconv -f CP932 -t UTF-8
}

#### FILER ####
if [ -n "$(command -v exa)" ]; then
    alias ls='exa -lhb --git --icons'
    alias ll='exa -hb --git --icons'
    alias la='exa -alhbHSg --git --icons'
    alias lla='exa -alhbHSg --git --icons'
else
    alias ls='ls'
    alias ll='ls -l'
    alias la='ls -a'
    alias lla='ls -al'
fi

# explorer
function open_filer(){
    if [ $# -eq 0 ] ; then
        TARGET=$PWD
    else
        TARGET=$1
    fi
    
    if [ -n "$(command -v cygpath)" ]; then
        TARGET=$(cygpath -w "$TARGET")
        explorer.exe "$TARGET"
    else
        echo "TODO IMPLEMENTED !!"
    fi
}
alias x=open_filer

#### TMUX ####
alias ta="tmux a"
alias tl="tmux ls"

#### Git ####
# git (abbreveations)
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gf="git fetch --all"
alias gs="git status --short --branch --show-stash"
alias ga="git add ."
alias gl="git log --graph --all --branches --tags --remotes --abbrev-commit --oneline"
alias gd="git diff"
alias gp="git push"

# git-remind
alias grj="git remind status -n --all | fzf --ansi --cycle --preview=\"git -C {} -c color.status=always status -vv --branch --show-stash\" | cd"
alias grs='git remind status --all'

# ghq
alias gj='cd $(ghq list | fzf --ansi --cycle --preview "bat --color=always --style=grid --line-range :80 $(ghq root)/{}/README.*" | xargs -t -I{} echo $(ghq root)/{})'
if [ "$TERM_PROGRAM" = "mintty" ]; then
    alias gj="echo 'fzf is not available in mintty.'"
fi

# github cli
alias gx="hub browse"

#### PYTHON ####
alias i=ipython

# TODO: 対処療法的なのでちゃんとmsysとlinuxを判別したい
PYTHON_DEFAULT_VENV="${PYTHON_DEFAULT_VENV:-$HOME/venvs/default}"
if [ -n "$(command -v cygpath)" ]; then
    alias activate_default="source $PYTHON_DEFAULT_VENV/Scripts/activate"
else
    alias activate_default="source $PYTHON_DEFAULT_VENV/bin/activate"
fi

# esapy
alias esafu='esa up --no-browser "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'
alias esafr='esa reset "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'
