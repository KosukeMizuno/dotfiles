# KosukeMizuno/DOTFILES

Multi-platform dotfiles with automatic instalation and deploying scripts.

- [ ] windows
- [x] centos
- [ ] other linux system

## How to install

### Building CLI environment

If you are in proxy environment, set `HTTP_PROXY` before `make`.

- Clone & install
  ```sh
  export DOTPATH=$HOME/dotfiles
  git clone --recursive <this repo> $DOTPATH
  cd $DOTPATH
  make
  ```
- Then, make zsh a default shell if permission is available.
  ```sh
  echo $HOME/.local/bin/zsh >> /etc/shells
  chsh -s $HOME/.local/bin/zsh
  ```
  If not, zsh is executed automatically (See `.bash_profile`).

### IME

Editing japanese language with vim, 

- Windows:
  - `imeoff.exe` (by AutoHotKey) should be executable.
- Ubuntu:
  - `xvkbd` should be installed
  - `Muhenkan` key should make IME off whenever it is sent (this key will be sent at InsertLeave event).


### CI with docker-compose

- `sudo docker-compose up --force-recreate -d`
- `sudo docker-compose exec centos8 bash --login`

## Directory Structure

Defaults and recommendations: 
- `$DOTPATH=$HOME/dotfiles`
- `$PREFIX=$HOME/.local`
- `$PYTHON_DEFAULT_VENV=$HOME/venvs/default`

### Prefix

```
$PREFIX/bin -- とりあえずPATHを通したいものやコンパイル済みバイナリはココへ入れる
$PREFIX/src -- 自分でコンパイルするもの置き場
$PREFIX/opt -- 自分でコンパイルしないもの, vim用python_venvなど
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
~/.profile       ==> $DOTPATH/sh/profile

~/.bashrc        ==> $DOTPATH/sh/bashrc
~/.bash_profile  ==> $DOTPATH/sh/bash_profile 

~/.p10k.zsh   -- 手動管理。なければ初めにコピーされるが、それぞれの環境で`p10k configure`する。
~/.zlogin     ==> リンク
~/.zlogout    ==> リンク
~/.zpreztorc  ==> リンク
~/.zprofile   ==> リンク
~/.zshenv     ==> リンク
~/.zshrc      ==> リンク

~/.shrc_local        -- 手動で配置する。各環境用の設定を書く（あればbashrcの中で読まれる, git管理対象外）
~/.sh_profile_local  -- 手動で配置する。各環境用の設定を書く（あればbash_profileの中で読まれる, git管理対象外）
~/.sh_secure         -- 手動で書く。git管理したくないもの（あればbash_profileの中で読まれる, git管理対象外）
```

`ZSH_DO_PROFILING=true`など設定された状態でzshを起動すると、`.zshenv`の中で`zsh/zprof`が有効化されてプロファイリングが走る

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

`init.vim`の検証用に設定フォルダの切り替えスクリプトを用意した: `./bin/relink_nvim_config`
`$XDG_CONFIG_HOME/nvim`に`$DOTPATH/nvim` or `$DOTPATH/nvim_test`へのリンクがはられる。


## Acknowledgements

- `./bin/lazyenv.bash` was copied from <https://github.com/takezoh/lazyenv>
- `./bin/check_nerdfont.sh` was copied from <https://takuzoo3868.hatenablog.com/entry/2018/12/28/032148>
- zsh-related rc scripts `./sh/.z*` was initially copied from [sorin-ionescu/prezto](https://github.com/sorin-ionescu/prezto) and then customized.

