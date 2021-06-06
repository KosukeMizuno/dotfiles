# README

## with docker-compose
- `sudo docker-compose up --build -d && sudo docker-compose exec centos8 bash`
- `sudo docker-compose exec centos8 bash --login`

## How to install
- ```sh
  export DOTPATH=$HOME/dotfiles; 
  git clone --recursive <this repo> $DOTPATH && cd $DOTPATH && make
  ```

## Directory Structure

Defaults and recommendations: 
- `$DOTPATH=$HOME/dotfiles`
- `$PREFIX=$HOME/.local`
- `$PYTHON_DEFAULT_VENV=$HOME/venvs/default`

### Prefix

```
$PREFIX/bin -- とりあえずPATHを通したいものやコンパイル済みバイナリはココへ入れる
$PREFIX/src -- 自分でコンパイルするもの置き場
$PREFIX/opt -- 自分でコンパイルしないもの置き場
```

### git

```
~/.gitconfig_local  -- 手動で設定する（git管理対象外）
~/.gitconfig  ==> $DOTPATH/.config/git/config
$DOTPATH/.config/git/config  -- global config の本体
$DOTPATH/.config/git/ignore  -- global ignore
```

### Bash & Zsh
```
~/.bashrc             ==> $DOTPATH/sh/bashrc
~/.shrc_local        -- 手動で配置する。各環境用の設定を書く（あればbashrcの中で読まれる, git管理対象外）
~/.bash_profile       ==> $DOTPATH/sh/bash_profile 
~/.sh_profile_local  -- 手動で配置する。各環境用の設定を書く（あればbash_profileの中で読まれる, git管理対象外）

~/.sh_secure         -- 手動で書く。git管理したくないもの（あればbash_profileの中で読まれる, git管理対象外）
```

`$ZSH_DO_PROFILING`に何か設定された状態でzshを起動すると、`.zshenv`の中で`zsh/zprof`が有効化されてプロファイリングが走る

### Python

仮想環境は`~/venvs/`に置く。

```
~/venvs/default  -- デフォルトで使用する環境, 現在は3.8
```

### Neovim

設定フォルダは`$DOTPATH/nvim`においている。
Note: `$DOTPATH/.config/nvim`ではないので注意。よくアクセスするので浅いところにした。

git管理しない設定ファイルは`$DOTPATH/nvim/set_credential.vim`（あればinit.vimで読まれる）

vim用のpython3(venv)は`$PREFIX/opt/python3_nvim`においた。
python2って要る？


## Acknowledgement

- `./bin/lazyenv.bash` was copied from <https://github.com/takezoh/lazyenv>
- zsh-related rc scripts `./sh/.z*` was initially copied from [sorin-ionescu/prezto](https://github.com/sorin-ionescu/prezto) and then customized.
