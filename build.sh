#!/bin/sh

cd $(dirname $0)
docker build -t dotfiles_portable:latest .
