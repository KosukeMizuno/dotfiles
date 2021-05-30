#!/bin/bash

#### install.sh ####
# 必要なツールがなければ知らせる＆可能ならインストールする

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
PATH="$DOTPATH/bin:$HOME/.local/bin:$PATH"

# check local path
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/src"
mkdir -p "$HOME/.local/opt"
mkdir -p "$HOME/.local/share/fonts"

#### 順番はあとで適当に変えたい
## bash

## zsh
# TODO


## tmux
if [ -z $(command -v tmux) ]; then
    _pwd=$PWD

    # libevent
    if [ ! -f "$HOME/.local/lib/libevent_core-2.1.so.7" ]; then
        [ -d $HOME/.local/src/libevent-2.1.12-stable ] && rm $HOME/.local/src/libevent-2.1.12-stable -rf
        url=https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
        wget $url -P /tmp
        tar zxvf /tmp/$(basename $url) -C $HOME/.local/src
    fi
    cd $HOME/.local/src/libevent-2.1.12-stable
    [ -d build ] && rm build/ -rf
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local ..
    make
    make install

    # tmux-3.2
    if [ ! -d "$HOME/.local/src/tmux" ]; then
        url=https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz
        wget $url -P /tmp
        tar zxvf /tmp/$(basename $url) -C $HOME/.local/src
    fi
    ./configure --prefix=$HOME/.local
    make
    make install

    cd $_pwd
fi


## nvim

## terminal

# alacritty windows-terminal

# font
if [ $(fc-list | grep Cica | wc -l) -eq 0 ]; then
    echo "Installing Cica font..."
    url=https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
    dname=$(mktemp -d --suffix=$(basename $url .zip))
    wget $url -P /tmp
    unzip /tmp/$(basename $url) -d $dname
    cp $dname/*.ttf $HOME/.local/share/fonts/
    fc-cache -fv
fi
if [ $(fc-list | grep HackGen | wc -l) -eq 0 ]; then
    echo "Installing HackGen font..."
    url=https://github.com/yuru7/HackGen/releases/download/v2.3.2/HackGenNerd_v2.3.2.zip
    dname=$(mktemp -d --suffix=$(basename $url .zip))
    wget $url -P /tmp
    unzip /tmp/$(basename $url) -d $dname
    cp $dname/HackGenNerd_v2.3.2/*.ttf $HOME/.local/share/fonts/
    fc-cache -fv
fi
if [ $(fc-list | grep "MesloLGS NF" | wc -l) -eq 0 ]; then
    echo "Installing Meslo font..."
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P $HOME/.local/share/fonts
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P $HOME/.local/share/fonts
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P $HOME/.local/share/fonts
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P $HOME/.local/share/fonts
    fc-cache -fv
fi




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
# git-remind
if [ -z $(command -v git-remind) ]; then
    url=https://github.com/suin/git-remind/releases/download/v1.1.1/git-remind_1.1.1_Linux_x86_64.tar.gz
    wget $url -P /tmp
    dname=$HOME/.local/opt/$(basename $url .tar.gz)
    mkdir -p $dname
    tar zxvf /tmp/$(basename $url) -C $dname
    ln -s $dname/git-remind $HOME/.local/bin/git-remind
fi

## fzf
if [ -z $(command -v fzf) ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.local/opt/fzf
    $HOME/.local/opt/fzf/install --bin
    ln -s $HOME/.local/opt/fzf/bin/fzf $HOME/.local/bin/fzf
fi

## other things
# neofetch
if [ -z $(command -v neofetch) ]; then
    git clone https://github.com/dylanaraps/neofetch $HOME/.local/opt/neofetch
    cd $HOME/.local/opt/neofetch
    make PREFIX=$HOME/.local install
    cd -
fi

## asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
    source "$HOME/.asdf/asdf.sh"
elif [ -f "$HOME/ghq/github.com/asdf-vm/asdf/asdf.sh" ]; then
    source "$HOME/ghq/github.com/asdf-vm/asdf/asdf.sh"
fi
if [ -z $(command -v asdf) ]; then
    echo "command asdf was not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git $HOME/ghq/github.com/asdf-vm/asdf
    ln -s $HOME/ghq/github.com/asdf-vm/asdf $HOME/.asdf
    git -C $HOME/.asdf checkout "$(git describe --abbrev=0 --tags)"
    source $HOME/.asdf/asdf.sh
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
install_goget () {
    # $1 - command
    # $2 - url
    [ -z $(command -v $1) ] && go get -u $2
}
install_goget gomi github.com/b4b4r07/gomi
asdf reshim golang

## Rust
# Note: rust & rust-based tools are installed without asdf.
if [ ! -f $HOME/.cargo/env ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
source $HOME/.cargo/env
install_cargo () {
    # $1 - command
    # $2 - crate name, default: $1
    [ -z $(command -v $1) ] && cargo install ${2:-$1}
}
install_cargo exa
install_cargo rg ripgrep
install_cargo bat

## Node.js
install_asdf node nodejs lts
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