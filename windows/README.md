# win10 セットアップメモ

## GUIでやること

- cap2ctrl を入れる
- IMEの設定
  - 常に半角スペース
  - Ctrl+SpaceでIME切り替え

## 開発環境セットアップ (書きかけ, msys2版)

途中
参考：[MSYS2でWindowsのターミナル環境構築 | HY Techs](https://hyrorre.com/post/winterminal/#i-3)

- Install msys2
  - Windows環境変数に`HOME=C:\Users\<username>`を追加する
- pacman
  - sync & upgrade -- `pacman -Syuu`


## Setup (git for windows版)

- Install tools
  - git for windows (これのbashを使う)
  - LinkShellExtension
  - [HackGenNerd Console font](https://github.com/yuru7/HackGen/releases)
- Clone dotfiles repository
  - `git clone https://github.com/KosukeMizuno/dotfiles.git ~/ghq/KosukeMizuno/dotfiles`
  - `~ghq/KosukeMizuno/dotfiles` -> `~/dotfiles`
- Make symbolic links
  - `~/dotfiles/.config/*` -> `~/.config/*`
  - `~/dotfiles/.config/git/config` -> `~/.gitconfig`
  - `~/dotfiles/.config/git/config_local_template` -> `~/.gitconfig_local`
  - `~/dotfiles/nvim` -> `~/.config/nvim`
  - `~/dotfiles/python/ipython_startup` -> `~/.ipython/profile_default/startup`
- Copy setting templates
  - `~/dotfiles/windows/windowsterminal/setting.json` -> `~/AppData/Local/Microsoft/Windows Terminal/setting.json`
- シェル環境準備
  - `~/.local/` とそれ以下に `bin`, `opt`, `share`, `src` を作成
  - Install golang
    - <https://golang.org/dl/> からzip版を落として `~/.local/opt/go1.17.2` のように配置（GOなのでとりあえず最新版でOK？）
    - シンボリックリンクを張る `~/.local/opt/go1.17.2` -> `~/.local/opt/go`
    - ```sh
      go get -u github.com/x-motemen/ghq
      go get -u github.com/b4b4r07/gomi
      go get -u mvdan.cc/sh/v3/cmd/shfmt
      go get -u github.com/atotto/clipboard/cmd/gocopy
      go get -u github.com/atotto/clipboard/cmd/gopaste
      ```
  - Install rust (いろいろscoopでいれるから要らないんじゃね？)
    - Install [Visual Studio C++ Build tools](https://visualstudio.microsoft.com/ja/visual-cpp-build-tools/)
    - Install [rustup](https://www.rust-lang.org/tools/install)
  - Install deno
    - <https://deno.land/manual/getting_started/installation>

- Install scoop
  - https://scoop.sh/
  - `scoop bucket add extras`
  - `scoop install windows-terminal starship delta ripgrep fzf direnv`

- Install python
  - 3.8.10 -> https://www.python.org/downloads/windows/
  - `py -3.8 -m venv "$PYTHON_DEFAULT_VENV"`
  - `(source "$PYTHON_DEFAULT_VENV/Scripts/activate" && python -m pip install --upgrade pip autopep8 isort && pip install jupyterlab nbdime && pip install numpy scipy matplotlib cython tqdm better_exceptions numba && pip install qutip)`

- Install nvim
  - `py -3.8 -m venv "$PREFIX/opt/python3_nvim"`
  - `(source "$PREFIX/opt/python3_nvim/Scripts/activate" && python -m pip install --upgrade pip neovim pynvim)`
  - `ghq get Shougo/dein`
  - Install neovim: `https://github.com/neovim/neovim/releases/tag/stable`
