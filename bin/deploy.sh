#!/bin/bash

#### deploy.sh ####
# 設定ファイル群を展開する

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
source "$DOTPATH/sh/path.sh"
PATH="$DOTPATH/bin:$PATH"

deploy_ln "$DOTPATH/.config" "$XDG_CONFIG_HOME"

## bash
deploy_ln "$DOTPATH/sh/.bashrc" "$HOME/.bashrc"
deploy_ln "$DOTPATH/sh/.bash_profile" "$HOME/.bash_profile"

## zsh
# TODO

## ssh (copy)
if [ ! -d "$HOME/.ssh" ]; then mkdir "$HOME/.ssh"; fi
if [ ! -f "$HOME/.ssh/config" ]; then cp "$DOTPATH/ssh/config_template" "$HOME/.ssh/config"; fi
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519"; fi
find "$HOME/.ssh" -type d -print0 | xargs -0 chmod 700
find "$HOME/.ssh" -type f -print0 | xargs -0 chmod 600

## git
# XDG_CONFIG_HOME/git/gitconfig より ~/.gitconfig が優先されるのでリンクしておく
deploy_ln "$XDG_CONFIG_HOME/git/gitconfig" "$HOME/.gitconfig"

## python

# jupyter


## latex


## terminal: alacritty windows-terminal