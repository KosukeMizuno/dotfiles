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

### Prefix
```
$PREFIX/bin -- とりあえずPATHを通したいものやコンパイル済みバイナリはココへ入れる
$PREFIX/src -- 自分でコンパイルするもの置き場
$PREFIX/opt -- 自分でコンパイルしないもの置き場
```

### Bash & Zsh
```
~/.bashrc             ==> $DOTPATH/sh/bashrc
~/.bashrc_local        -- 手動で配置する。各環境用の設定を書く（あればbashrcの中で読まれる）
~/.bash_profile       ==> $DOTPATH/sh/bash_profile 
~/.bash_profile_local  -- 手動で配置する。各環境用の設定を書く（あればbash_profileの中で読まれる）

~/.sh_secure         -- 手動で書く。git管理したくないもの（あればbash_profileの中で読まれる）
```

## Acknowledgement

- `./bin/lazyenv.bash` was copied from <https://github.com/takezoh/lazyenv>
