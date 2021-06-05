#!/bin/bash

if [ -n "$BASH" ]; then
    for sc in "$DOTPATH"/sh/completion.d/*.bash; do
        source "$sc"
    done
elif [ -n "$ZSH_NAME" ]; then
    for sc in "$DOTPATH"/sh/completion.d/*.zsh; do
        source "$sc"
    done
fi