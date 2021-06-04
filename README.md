# README

## with docker-compose
- `sudo docker-compose up --build -d && sudo docker-compose exec centos8 bash`
- `sudo docker-compose exec centos8 bash`

## How to install
- `~/dotfiles/bin/install.sh && source ~/.asdf/asdf.sh`

## Directory Structure

Defaults and recommendations: 
- `$DOTPATH=$HOME/dotfiles`
- `$PREFIX=$HOME/.local`
- `$PYTHON_DEFAULT_VENV=$HOME/.venv_default`

$PREFIX/src ... 自分でコンパイルするもの置き場
$PREFIX/opt ... 自分でコンパイルしないもの置き場

