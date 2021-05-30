#!/bin/bash

#### install.sh ####
# 必要なツールがなければ知らせる＆可能ならインストールする

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
PATH="$DOTPATH/bin:$PATH"

## bash

## zsh
# TODO

# tmux

# nvim

## terminal

# alacritty windows-terminal

# font


## ssh
if [ -z $(command -v ssh) ]; then
    echo "command ssh was not found."
fi
if [ -z $(command -v wget) ]; then
    echo "command wget was not found."
fi
if [ -z $(command -v curl) ]; then
    echo "command curl was not found."
fi

## git
if [ -z $(command -v git) ]; then
    echo "command git was not found."
    exit 1
    # gitなかったら後段無理なので終了
fi

## asdf
if [ -z $(command -v asdf) ]; then
    if [ ! -d "$HOME/.asdf" ] && [ ! -d "$HOME/ghq/github.com/asdf-vm/asdf" ]; then
        echo "command asdf was not found. Installing..."
        git clone https://github.com/asdf-vm/asdf.git $HOME/ghq/github.com/asdf-vm/asdf
        ln -s $HOME/ghq/github.com/asdf-vm/asdf $HOME/.asdf
        git -C $HOME/.asdf checkout "$(git describe --abbrev=0 --tags)"
        source $HOME/.asdf/asdf.sh
    else
        echo "command asdf was not found, but it seems existing outside PATH."
        exit 1
        # TODO: とりあえず終了させておく。自動で通るようにしたい。
    fi
fi

install_asdf(){
    # $1 - command
    # $2 - plugin name, default: $1
    # $3 - version, default: latest
    if [ -z $(command -v $1) ]; then
        echo "command $1 was not found. Installing..."
        asdf plugin add ${2:-$1}
        asdf install ${2:-$1} ${3:-latest}
        asdf global ${2:-$1} ${3:-latest}
    fi
}

## go & go-tools
install_asdf go golang
install_asdf ghq
install_asdf direnv
go get -u github.com/b4b4r07/gomi
asdf reshim golang

## Rust
# Note: rust & rust-based tools are installed without asdf.
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
install_cargo () {
    [ -z $(command -v $1) ] && cargo install $1
}
install_cargo exa
install_cargo ripgrep
install_cargo bat

## Node.js
install_asdf nodejs nodejs lts
install_npm () {
    [ -z $(command -v $1) ] && npm install -g $1
}
install_npm tldr
asdf reshim nodejs

## Python
install_asdf python python 3.8.9

# poetry
[ -f $HOME/.poetry/env ] && source $HOME/.poetry/env
if [ -z $(command -v poetry) ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
    source $HOME/.poetry/env
fi

## Perl

## LaTeX