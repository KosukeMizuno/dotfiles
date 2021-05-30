#!/bin/bash

#### deploy.sh ####
# 設定ファイル群を展開する

# check DOTPATH
if [ -z "$DOTPATH" ]; then
    echo "Ensure $DOTPATH is set."
    exit 1
fi
PATH="$DOTPATH/bin:$PATH"

## proxy settings (if needed)
# skip

## bash


## zsh
# TODO

## ssh (copy)
if [ ! -d "$HOME/.ssh" ]; then mkdir "$HOME/.ssh"; fi
if [ ! -f "$HOME/.ssh/config" ]; then cp "$DOTPATH/ssh/config_template" "$HOME/.ssh/config"; fi
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then ssh-keygen -t ed25519 -N '' -f "$HOME/.ssh/id_ed25519"; fi
find "$HOME/.ssh" -type d -print | xargs chmod 700
find "$HOME/.ssh" -type f -print | xargs chmod 600

## git (link)
deploy_ln "$DOTPATH/git/gitconfig" "$HOME/.gitconfig"
deploy_ln "$DOTPATH/git/gitignore_global" "$HOME/.config/git/ignore"

# go: ghq direnv trash

# rust: exa bat ripgrep

# nodejs

# python

# poetry
deploy_ln "$DOTPATH/python/pypoetry/config.toml" "$HOME/.config/pypoetry/config.toml"

# jupyter

# perl

# latex

# tmux

# nvim

# terminal: alacritty windows-terminal