# KosukeMizuno/DOTFILES

Multi-platform dotfiles with automatically installing and deploying scripts.

- [ ] windows
- [x] wsl
- [x] centos
- [ ] other linux system

## How to install

### Building CLI environment

Set `HTTP_PROXY` before `make` if needed.

- Update a package manager and install dependencies
  - for Ubuntu
    ```sh
    sudo apt update && sudo apt upgrade -y
    sudo apt install build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev
    sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    ```
- Clone & install
  ```sh
  export DOTPATH=$HOME/dotfiles
  git clone --recursive "https://github.com/KosukeMizuno/dotfiles.git" "$DOTPATH"
  cd "$DOTPATH"
  make
  ```
- Make a symlink to the dotfiles directory into the ghq folder.
  ```sh
  ln -s "$DOTPATH" "$(ghq root)/github.com/KosukeMizuno/dotfiles"
  ```
- Then, make zsh a default shell if you can sudo.
  ```sh
  echo $HOME/.local/bin/zsh >> /etc/shells
  chsh -s $HOME/.local/bin/zsh
  ```
  If not, zsh is executed automatically (See `.bash_profile`).

### IME

Editing japanese language with vim,

- Windows (mingw):
  - Nothing is needed.
  - [pepo-le/win-ime-con.nvim](https://github.com/pepo-le/win-ime-con.nvim) set IME off at leaving the insert mode.
- Windows (wsl):
  - `scoop install zenhan`
- Ubuntu:
  - Install `xvkbd` by apt.
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

$DOTPATH/wsl_ubuntu/bin -- wsl環境でだけPATHを通したいものを入れておく（ラッパースクリプトなど）
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

いつでも使いたい仮想環境は`~/venvs/`に置く。

```
~/venvs/default  -- デフォルトで使用する環境, 現在は3.8
```

環境変数`USE_ANACONDA` がtrueなら、`PATH_CONDA_SH`で指定されたファイルを読み込み、さらに`DEFAULT_ENV_CONDA`が指定されていればactivateする。
（例：`PATH_CONDA_SH="~/anaconda3/etc/profile.d/conda.sh"`）

`USE_ANACONDA` がtrueならvenv/defaultはactivateされない

### Neovim

設定フォルダは`$DOTPATH/nvim`においている。  
Note: `$DOTPATH/.config/nvim`ではないので注意。よくアクセスするので浅いところにした。
git管理しない設定ファイルは`$DOTPATH/nvim/set_credential.vim`（あればinit.vimで読まれる）

vim用のpython3(venv)は`$PREFIX/opt/python3_nvim`においた。

`init.vim`の検証用に設定フォルダの切り替えスクリプトを用意した: `./bin/relink_nvim_config`
`$XDG_CONFIG_HOME/nvim`に`$DOTPATH/nvim` or `$DOTPATH/nvim_test`へのリンクがはられる。


## Acknowledgements

- `./bin/lazyenv.bash` was copied from <https://github.com/takezoh/lazyenv>
- `./bin/check_nerdfont.sh` was copied from <https://takuzoo3868.hatenablog.com/entry/2018/12/28/032148>
- zsh-related rc scripts `./sh/.z*` was initially copied from [sorin-ionescu/prezto](https://github.com/sorin-ionescu/prezto) and then customized.

