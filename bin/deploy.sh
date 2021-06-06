#!/bin/bash

#### deploy.sh ####
# 設定ファイル群を展開する

# 環境チェック
if [ "$(uname)" != "Linux" ]; then
    echo "This install script is written for Linux system." 1>&2
    exit 1
fi

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
source "$DOTPATH/sh/path.sh"
PATH="$DOTPATH/bin:$PATH"

# ensure local path
mkdir -p "$XDG_CONFIG_HOME"

## bash
deploy_ln "$DOTPATH/sh/.bashrc" "$HOME/.bashrc"
deploy_ln "$DOTPATH/sh/.bash_profile" "$HOME/.bash_profile"

## zsh
deploy_ln "$DOTPATH/sh/.zlogin"    "$HOME/.zlogin"
deploy_ln "$DOTPATH/sh/.zlogout"   "$HOME/.zlogout"
deploy_ln "$DOTPATH/sh/.zpreztorc" "$HOME/.zpreztorc"
deploy_ln "$DOTPATH/sh/.zprofile"  "$HOME/.zprofile"
deploy_ln "$DOTPATH/sh/.zshenv"    "$HOME/.zshenv"
deploy_ln "$DOTPATH/sh/.zshrc"     "$HOME/.zshrc"
[ ! -f "$HOME/.p10k.zsh" ] && cp "$DOTPATH/sh/.p10k.zsh_template" "$HOME/.p10k.zsh"

## ssh (copy)
if [ ! -d "$HOME/.ssh" ]; then mkdir "$HOME/.ssh"; fi
if [ ! -f "$HOME/.ssh/config" ]; then cp "$DOTPATH/.ssh/config_template" "$HOME/.ssh/config"; fi
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519"; fi
find "$HOME/.ssh" -type d -print0 | xargs -0 chmod 700
find "$HOME/.ssh" -type f -print0 | xargs -0 chmod 600

## git
# XDG_CONFIG_HOME/git/config より ~/.gitconfig が優先される、
# かついろんな機会に踏み荒らされがちなのでリンクしておく
deploy_ln "$DOTPATH/.config/git" "$XDG_CONFIG_HOME/git"
deploy_ln "$XDG_CONFIG_HOME/git/config" "$HOME/.gitconfig"
[ ! -f "$HOME/.gitconfig_local" ] && cp "$DOTPATH/.config/git/config_local_template" "$HOME/.gitconfig_local"

## tmux
deploy_ln "$DOTPATH/.config/tmux" "$XDG_CONFIG_HOME/tmux"

## nvim
deploy_ln "$DOTPATH/nvim" "$XDG_CONFIG_HOME/nvim"

## python
deploy_ln "$DOTPATH/.config/pypoetry" "$XDG_CONFIG_HOME/pypoetry"
deploy_ln "$DOTPATH/.config/pycodestyle" "$XDG_CONFIG_HOME/pycodestyle"
deploy_ln "$DOTPATH/ipython_startup" "$HOME/.ipython/profile_default/starup"

# jupyter


## latex


## terminal: alacritty windows-terminal
deploy_ln "$DOTPATH/.config/alacritty" "$XDG_CONFIG_HOME/alacritty"
