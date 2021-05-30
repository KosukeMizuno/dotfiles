#!/bin/bash

#### install.sh ####
# 必要なツールがなければ知らせる＆可能ならインストールする

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
PATH="$DOTPATH/bin:$PATH"

## ssh
if [ -z $(command -v ssh) ]; then
    echo "command `ssh` was not found."
fi
if [ -z $(command -v wget) ]; then
    echo "command `wget` was not found."
fi
if [ -z $(command -v curl) ]; then
    echo "command `curl` was not found."
fi

## git
if [ -z $(command -v git) ]; then
    echo "command `git` was not found."
    exit 1
    # gitなかったら後段無理なので終了
fi

## asdf
if [ -z $(command -v asdf) ] && [ ! -d "$HOME/.asdf" ] && [ ! -d "$HOME/ghq/github.com/asdf-vm/asdf" ]; then
    echo "command `asdf` was not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git $HOME/ghq/github.com/asdf-vm/asdf
    ln -s $HOME/ghq/github.com/asdf-vm/asdf $HOME/.asdf
    git -C $HOME/.asdf checkout "$(git describe --abbrev=0 --tags)"
    source $HOME/.asdf/asdf.sh
else
    echo "command `asdf` was not found, but it seems existing outside PATH."
    exit 1
    # TODO: とりあえず終了させておく。自動で通るようにしたい。
fi

install_asdf(){
    # $1 - command
    # $2 - version, default: latest
    if [ -z $(command -v $1) ]; then
        echo "command `$1` was not found. Installing..."
        asdf plugin add $1
        asdf install $1 ${2:-latest}
        asdf global $1 ${2:-latest}
    fi
}

# go & go-tools
install_asdf golang
install_asdf ghq

# gotools: direnv trash tldr

# # direnv (これはasdfに依存させたくない)
# if [ z $(command -v direnv) ]; then
#     echo "command `$1` was not found. Installing..."
#     git clone https://github.com/direnv/direnv.git $HOME/.local/src/direnv --branch v2.28.0
#     cd  $HOME/.local/src/direnv
#     make
# fi

# rust: exa bat ripgrep

# nodejs

# python

# jupyter

# perl

# latex

# zsh

# tmux

# nvim

# terminal: alacritty windows-terminal