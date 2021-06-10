#!/bin/bash

#### install.sh ####
# 必要なツールがなければ知らせる＆可能ならインストールする

# 環境チェック
if [[ $(uname) != "Linux" ]]; then
    echo "This install script is written for Linux system." 1>&2
    exit 1
fi

# check DOTPATH and PREFIX
if [[ -z $DOTPATH ]]; then
    echo "Ensure \$DOTPATH is set." 1>&2
    exit 1
fi

unalias -a
source "$DOTPATH/sh/path.sh"
PATH="$DOTPATH/bin:$PATH"

# ensure local path
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$PREFIX/bin"
mkdir -p "$PREFIX/src"
mkdir -p "$PREFIX/opt"
mkdir -p "$PREFIX/share/fonts"

## zsh
if ${DOTINSTALL_ZSH:-true}; then

    if [[ -z $(command -v zsh) ]]; then
        if [[ ! -d "$PREFIX/src/zsh-5.8" ]]; then
            url="https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz/download"
            wget $url -P /tmp
            tar xvf "/tmp/$(basename $url)" -C "$PREFIX/src"
        fi
        (cd "$PREFIX/src/zsh-5.8" && {
            ./configure --prefix="$PREFIX"
            make
            make install
        })
    fi

    # zprezto
    if [[ ! -d "$HOME/.zprezto" ]]; then
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    fi

fi

## tmux
if ${DOTINSTALL_TMUX:-true}; then

    # libevent
    # TODO: ここの条件式大丈夫？
    if (! ldconfig -p | grep -q "libevent_core-2.1.so.7") &&
        (! find "$PREFIX/lib/" -name "libevent_core-2.1.so.7" -type f -or -type l | grep -q "libevent-2.1.so.7"); then
        if [[ ! -d "$PREFIX/src/libevent-2.1.12-stable" ]]; then
            url="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
            wget $url -P /tmp
            tar zxvf "/tmp/$(basename $url)" -C "$PREFIX/src"
        fi
        (cd "$PREFIX/src/libevent-2.1.12-stable" && {
            ./configure --prefix="$PREFIX"
            make
            make install
        })
    fi

    # tmux-3.2
    if [[ -z $(command -v tmux) ]]; then
        if [[ ! -d "$PREFIX/src/tmux-3.2" ]]; then
            url="https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz"
            wget $url -P /tmp
            tar zxvf "/tmp/$(basename $url)" -C "$PREFIX/src"
        fi
        (cd "$PREFIX/src/tmux-3.2" && {
            ./configure --prefix="$PREFIX"
            make
            make install
        })
    fi

fi

## terminal

# alacritty windows-terminal

# font
if ${DOTINSTALL_FONTS:-true}; then
    if [[ $(fc-list | grep -c Cica) -eq 0 ]]; then
        echo "Installing Cica font..."
        url=https://github.com/miiton/Cica/releases/download/v5.0.2/Cica_v5.0.2_with_emoji.zip
        dname=$(mktemp -d --suffix="$(basename $url .zip)")
        wget $url -P /tmp
        unzip "/tmp/$(basename $url)" -d "$dname"
        cp "$dname"/*.ttf "$PREFIX/share/fonts/"
        fc-cache -fv
    fi
    if [[ $(fc-list | grep -c HackGen) -eq 0 ]]; then
        echo "Installing HackGen font..."
        url=https://github.com/yuru7/HackGen/releases/download/v2.3.2/HackGenNerd_v2.3.2.zip
        dname=$(mktemp -d --suffix="$(basename $url .zip)")
        wget $url -P /tmp
        unzip "/tmp/$(basename $url)" -d "$dname"
        cp "$dname/HackGenNerd_v2.3.2"/*.ttf "$PREFIX/share/fonts/"
        fc-cache -fv
    fi
    if [[ $(fc-list | grep -c "MesloLGS NF") -eq 0 ]]; then
        echo "Installing Meslo font..."
        wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P "$PREFIX/share/fonts"
        wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P "$PREFIX/share/fonts"
        wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P "$PREFIX/share/fonts"
        wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P "$PREFIX/share/fonts"
        fc-cache -fv
    fi
fi

## ssh
if [[ -z $(command -v ssh) ]]; then
    echo "command ssh was not found." 1>&2
fi
if [[ -z $(command -v wget) ]]; then
    echo "command wget was not found." 1>&2
fi
if [[ -z $(command -v curl) ]]; then
    echo "command curl was not found." 1>&2
fi

## git
if [[ -z $(command -v git) ]]; then
    echo "command git was not found." 1>&2
    exit 1
    # gitなかったら後段無理なので終了
fi

## other things
# git-remind
if [[ -z $(command -v git-remind) ]]; then
    url="https://github.com/suin/git-remind/releases/download/v1.1.1/git-remind_1.1.1_Linux_x86_64.tar.gz"
    wget $url -P /tmp
    dname="$PREFIX/opt/$(basename $url .tar.gz)"
    mkdir -p "$dname"
    tar zxvf "/tmp/$(basename $url)" -C "$dname"
    ln -s "$dname/git-remind" "$PREFIX/bin/git-remind"
fi

# fzf
if [[ -z $(command -v fzf) ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$PREFIX/opt/fzf"
    "$PREFIX/opt/fzf/install" --bin
    for name in "$PREFIX/opt/fzf/bin"/*; do
        ln -s "$name" "$PREFIX/bin/$(basename "$name")"
    done
fi

# neofetch
if [[ -z $(command -v neofetch) ]]; then
    git clone https://github.com/dylanaraps/neofetch "$PREFIX/opt/neofetch"
    (
        cd "$PREFIX/opt/neofetch" &&
            make PREFIX="$PREFIX" install
    )
fi

## asdf
if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
    source "$HOME/.asdf/asdf.sh"
fi
if [[ -z $(command -v asdf) ]]; then
    echo "command asdf was not found. Installing..."
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf"
    git -C "$HOME/.asdf" checkout "$(git describe --abbrev=0 --tags)"
    source "$HOME/.asdf/asdf.sh"
fi
install_asdf() {
    # $1 - command
    # $2 - plugin name, default: $1
    # $3 - version, default: latest
    if ! asdf plugin list "${2:-$1}" | grep -q "${2:-$1}"; then
        echo "command $1 was not found. Installing..."
        asdf plugin add "${2:-$1}"
        asdf install "${2:-$1}" "${3:-latest}"
        asdf global "${2:-$1}" "${3:-latest}"
    fi
}

## go & go-tools
# TODO: なんかgolangのバージョン管理しなくていいんじゃね的な記事を読んだ
#       asdfに依存する必要ないんじゃない？
if ${DOTINSTALL_GOLANG:-true}; then
    install_asdf go golang
    install_asdf direnv
    install_goget() {
        # $1 - command
        # $2 - url
        [[ -z $(command -v "$1") ]] && go get -u "$2"
    }
    install_goget ghq github.com/x-motemen/ghq
    install_goget hub github.com/github/hub
    install_goget gomi github.com/b4b4r07/gomi
    install_goget shfmt mvdan.cc/sh/v3/cmd/shfmt
    asdf reshim golang
fi

## Rust
# Note: rust & rust-based tools are installed without asdf.
if ${DOTINSTALL_RUST:-true}; then
    if [[ ! -e "$HOME/.cargo/env" ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    fi
    source "$HOME/.cargo/env"
    install_cargo() {
        # $1 - command
        # $2 - crate name, default: $1
        [[ -z $(command -v "$1") ]] && cargo install "${2:-$1}"
    }
    install_cargo exa # TODO: exaがwindowsで使えないので共通化できるものを探したい
    install_cargo rg ripgrep
    install_cargo bat
fi

## Node.js
if ${DOTINSTALL_NODEJS:-true}; then
    install_asdf node nodejs lts
    install_npm() {
        [[ -z $(command -v "$1") ]] && npm install -g "$1"
    }
    install_npm tldr
    npm install -g neovim
    asdf reshim nodejs
fi

## Python
if ${DOTINSTALL_PYTHON:-true}; then
    # python
    #   Note: Following modules built successfully but were removed because they could not be imported: _ctypes
    #           と表示されるが、import ctypesとかできる。謎。
    if [[ ! -x $PREFIX/bin/python3.8 ]]; then
        echo "python3.8 was not found. Installing..."
        if [[ ! -d "$PREFIX/src/cpython-3.8.10" ]]; then
            url=https://github.com/python/cpython/archive/refs/tags/v3.8.10.tar.gz
            wget $url -P /tmp
            dname=$(mktemp -d)
            tar zxvf "/tmp/$(basename $url)" -C "$dname"
            progname=$(ls "$dname")
            mkdir -p "$PREFIX/src/$progname"
            cp -lR "$dname/$progname" "$PREFIX/src"
        fi
        (cd "$PREFIX/src/$progname" && {
            ./configure --prefix="$PREFIX" --enable-shared --enable-optimizations --with-lto
            make -j8

            if [[ -n $(find "$PREFIX/bin" -name python3) ]]; then
                make altinstall
            else
                make install
            fi
        })
    fi
    if [[ ! -d "$PYTHON_DEFAULT_VENV" ]]; then
        mkdir -p "$PYTHON_VENV_DIR"
        "$PREFIX/bin/python3.8" -m venv "$PYTHON_DEFAULT_VENV"
    fi

    # poetry
    [[ -e "$HOME/.poetry/env" ]] && source "$HOME/.poetry/env"
    if [[ -z $(command -v poetry) ]]; then
        curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
        source "$HOME/.poetry/env"
    fi

    # python tools, jupyter
    # TODO: requirements.txtベースにしたい
    default_pip=$PYTHON_DEFAULT_VENV/bin/pip
    if [[ -x $default_pip ]]; then
        $default_pip install --upgrade pip autopep8 isort
        $default_pip install jupyterlab nbdime
        $default_pip install numpy scipy matplotlib cython tqdm better_exceptions numba
        $default_pip install qutip
    fi
fi

## Perl
if ${DOTINSTALL_PERL:-true}; then
    # TODO
    :
fi

## LaTeX
if ${DOTINSTALL_LATEX:-true}; then
    # TODO
    :
fi

## nvim
if ${DOTINSTALL_NVIM:-true}; then
    if [[ -z $(command -v ghq) ]]; then
        echo "ghq was not found." 1>&2
        exit 1
    fi
    if ! ghq list | grep -q "neovim/neovim"; then
        echo "cloning neovim/neovim  ..."
        ghq get neovim/neovim
    fi

    (cd "$(ghq list -p | grep neovim/neovim)" && {
        git fetch

        # check update & build
        NVIM_TARGET_BRANCH="nightly"
        echo "neovim HEAD: $(git rev-parse HEAD)"
        echo "neovim nightly: $(git rev-parse $NVIM_TARGET_BRANCH)"
        if [[ ! -x "$PREFIX/bin/nvim" ]] || [[ $(git rev-parse HEAD) != $(git rev-parse $NVIM_TARGET_BRANCH) ]]; then
            echo "Building nvim-nightly..."
            git checkout $NVIM_TARGET_BRANCH
            make CMAKE_INSTALL_PREFIX="$PREFIX" CMAKE_BUILD_TYPE=Release
            make install
        fi
    }) || (
        # ビルドに失敗したらadsfで入れとく（sh/pash.sh を読めば ~/.local/binのほうが先にくるので、ビルドに成功すればそちらが使用される）
        install_asdf nvim neovim nightly
    )
    
    if [[ -n $(command -v nvim) ]]; then

        # python
        if [[ -x "$PREFIX/bin/python3.8" ]]; then
            VENV_FOR_NEOVIM="$PREFIX/opt/python3_nvim"
            if [[ ! -d "$VENV_FOR_NEOVIM" ]]; then
                "$PREFIX/bin/python3.8" -m venv "$VENV_FOR_NEOVIM"
            fi
            "$VENV_FOR_NEOVIM/bin/pip" install --upgrade pip neovim pynvim
        else
            echo "python3 was not found. Creating venv for nvim failed." 1>&2
        fi

        # dein.vim
        if ! ghq list | grep -q "Shougo/dein.vim"; then
            ghq get Shougo/dein.vim
        else
            DEIN_DIR=$(ghq list -p | grep "Shougo/dein.vim")
            git -C "$DEIN_DIR" pull
        fi

        mkdir -p "$HOME/.local/share/nvim/undo"
        mkdir -p "$HOME/.local/share/nvim/backup"
        mkdir -p "$HOME/.local/share/nvim/swap"

        # nvimの初回ダウンロード等が必要なものを実行
        nvim +q
        nvim "+call dein#check_update()" +q
        nvim "+UpdateRemotePlugins" "+TSInstall all" +q

    fi
fi
