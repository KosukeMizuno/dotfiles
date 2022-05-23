#### rc.alias.sh ####
# define aliases
# shellcheck disable=SC2139,SC2148,SC1090

#### COMMAND LINE HELPER
# reload rc
if [[ -n $BASH ]]; then
    alias rc='echo "sourcing ~/.bashrc ..."; source "$HOME/.bashrc"'
    alias rc_profile='echo "sourcing ~/.bash_profile ..."; source "$HOME/.bash_profile"'
elif [[ -n $ZSH_NAME ]]; then
    alias rc='echo "sourcing ~/.zshrc ..."; source "$HOME/.zshrc"'
    alias rc_profile='echo "sourcing ~/.zprofile ..."; source "$HOME/.zprofile"'
fi

# ランダム文字列を生成する
gen_ranodm_word() {
    randomword=$(dd if=/dev/random | tr -dc 0-9a-zA-Z | head "-c${1:-16}")
    echo "$randomword"
}

# URLエンコード
urlencode() {
  echo "$1" | nkf -WwMQ | tr = %
}

# 一時作業フォルダを作成して移動
alias cdtemp='cd "$(mktemp -d)"'
# dotfilesに移動
alias cdot='cd "${DOTPATH:-$HOME/dotfiles}"'

# PATHを一覧で出す
echo_path() {
    echo "$PATH" | tr ':' '\n'
}

# alias for mintty (winpty, encoding)
if [[ $TERM_PROGRAM = "mintty" ]]; then
    for name in node ipython python jupyter nvim; do
        alias $name="winpty $name"
    done

    for name in ipconfig ping netstat netsh; do
        alias $name="wincmd $name"
    done
fi

# encoding conversion for win
wincmd() {
    CMD=$1
    shift
    $CMD "$@" 2>&1 | iconv -f CP932 -t UTF-8
}

#### FILER ####
if [[ -n $(command -v exa) ]]; then
    if [[ -n $USE_ICON_IN_TERM ]] && $USE_ICON_IN_TERM; then
        ICON_FLG=" --icons"
    else
        ICON_FLG=""
    fi
    alias ls="exa -hb --git${ICON_FLG}"
    alias ll="exa -lhb --git${ICON_FLG}"
    alias la="exa -ahbHSg --git${ICON_FLG}"
    alias lla="exa -alhbHSg --git${ICON_FLG}"
else
    alias ls='ls'
    alias ll='ls -l'
    alias la='ls -a'
    alias lla='ls -al'
fi

# explorer
## TODO: こいつは実行可能ファイルに切り出したほうが便利
open_filer() {
    if [[ $# -eq 0 ]]; then
        TARGET="$PWD"
    else
        TARGET="$1"
    fi

    if $("$IS_MINGW"); then
        TARGET=$(cygpath -w "$TARGET")
        explorer.exe "$TARGET"
    elif $("$IS_WSL"); then
        TARGET=$(wslpath -w "$TARGET")
        /mnt/c/Windows/explorer.exe "$TARGET"
    elif $("$IS_NATIVE_LINUX"); then
        [[ -n $(command -v "xdg-open") ]] && xdg-open "$TARGET"
    else
        echo "A filer command to open file was not found: $1"
    fi
}
alias x=open_filer

# ripgrep: 隠しファイルは検索対象にする、ただしgitignoreは遵守
alias rg="rg --hidden --glob \!.git "

#### for WSL ####
if $("$IS_WSL") && [[ -n "$USERPROFILE" ]]; then
    alias code="$USERPROFILE/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
    alias gocopy="$USERPROFILE/.local/bin/gocopy"
    alias gopaste="$USERPROFILE/.local/bin/gopaste"
    alias explorer="/mnt/c/Windows/explorer.exe"
    alias cmd="/mnt/c/Windows/System32/cmd.exe"
fi

#### TMUX ####
alias t="tmux"
alias ta="tmux a"
alias tl="tmux ls"

# tmux-resurrectの再起動時にもたもたしていると新しいセッションができてしまうことがあるので、
# 最新を破棄＆古いセッションファイルを最新にして読み込めるようにする
# TODO: 書き直し
tmux-select-resurrect-session() {
    return 1;

    TMUXRESURRECTDIR="$HOME/.tmux/resurrect"
    unlink "$TMUXRESURRECTDIR/last"
    PREVCMD="cat $TMUXRESURRECTDIR/{}"
    SESSIONFILE=$(\ls "$TMUXRESURRECTDIR" | fzf --preview="$PREVCMD" --tac)
    echo "$SESSIONFILE"
    ln -s "$TMUXRESURRECTDIR/$SESSIONFILE" "$TMUXRESURRECTDIR/last"
}

#### Git ####
# git (abbreveations)
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gcamend="git commi --amend --no-edit"
alias gf="git fetch --all"
alias gs="git status --short --branch --show-stash"
alias ga="git add ."
alias gl="git log --graph --all --branches --tags --remotes --abbrev-commit --oneline"
alias gd="git diff"
alias gdc="git diff --cached"
alias gp="git push"
alias gpl="git pull"

# git-remind
alias grj="git remind status -n --all | fzf --inline-info --height 40% --ansi --cycle --preview=\"git -C {} -c color.status=always status -vv --branch --show-stash\" | cd"
alias grs='git remind status --all'

# ghq
__fzf_ghq_cd(){
    if [[ -n $(command -v bat) ]]; then
        target="$(ghq list | fzf --inline-info --height 40% --ansi --cycle --preview "bat --color=always --style=grid --line-range :40 '$(ghq root)'/{}/README.*")"
    else
        target="$(ghq list | fzf --inline-info --height 40% --ansi --cycle --preview "cat '$(ghq root)'/{}/README.* | head -40")"
    fi
    [[ -z $target ]] && return

    cd_target="$(ghq root)/$target"
    [[ ! -d "$cd_target" ]] && [[ ! -L "$cd_target" ]] && return
    cd "$cd_target"
}
if [[ $TERM_PROGRAM = "mintty" ]]; then
    alias gj="echo 'fzf is not available in mintty.'"
else
    alias gj=__fzf_ghq_cd
fi

# github cli
alias gx="hub browse"

#### FZF ####
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS=""

# kill with fzf
__fzf_kill() {
    target=$(ps -ef | sed 1d | fzf)
    if [[ -n $target ]]; then
        echo "target --> $target"
        echo "$target" | awk '{print $2}' | xargs kill -"${1:-9}"
    fi
}
alias fkill=__fzf_kill

# cd with fzf
__fzf_cd() {
    if [[ -n $(command -v exa) ]]; then
        target=$(exa -a --only-dirs | fzf --inline-info --ansi --cycle --height 50% --preview='exa --color=always {}')
    else
        target=$(ls -d */ .*/ | fzf --inline-info --ansi --cycle --height 50% --preview='ls --color=always {}')
    fi
    [[ ! -d "$target" ]] && [[ ! -L "$target" ]] && return
    cd "$target"
}
alias fcd=__fzf_cd
alias cdf=__fzf_cd

#### PYTHON ####
alias i=ipython

# TODO: 対処療法的なのでちゃんとmsysとlinuxを判別したい
# TODO: カレントディレクトリに venv があったら第一候補に追加したい
PYTHON_VENV_DIR="${PYTHON_VENV_DIR:-$HOME/venvs}"
PYTHON_DEFAULT_VENV="${PYTHON_DEFAULT_VENV:-$PYTHON_VENV_DIR/default}"
__fzf_activate_python_venv() {
    target=$(\ls "$PYTHON_VENV_DIR" | fzf --select-1)
    if [[ -d "$PYTHON_VENV_DIR/$target" ]]; then
        [[ -n $(command -v deactivate) ]] && deactivate

        if [[ -n $(command -v cygpath) ]]; then
            source "$PYTHON_VENV_DIR/$target/Scripts/activate"
        else
            source "$PYTHON_VENV_DIR/$target/bin/activate"
        fi
    fi
}
if "${USE_ANACONDA:-false}"; then
    :  # if true, anaconda make an `activate` executable in PATH.
else
    alias activate=__fzf_activate_python_venv
    if [[ -n $(command -v cygpath) ]]; then
        alias activate_default='source "$PYTHON_DEFAULT_VENV/Scripts/activate"'
    else
        alias activate_default='source "$PYTHON_DEFAULT_VENV/bin/activate"'
    fi
fi

# esapy
alias esafu='esa up --no-browser "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'
alias esafr='esa reset "$(esa ls | fzf | sed -r "s/(.+)\\| (.+)/\\2/")"'

# run jupyter notebook as date-named file
__run_ipynb() {
    target="$1"
    newnametmp="nbx_$(basename $target '.ipynb')-at$(date +%y%m%d%H%M)-XXXXXX.ipynb"
    newname=$(mktemp -p $(dirname "$target") "$newnametmp")
    /usr/bin/cp -f "$target" "$newname"
    jupyter nbconvert --debug --to notebook --execute "$target" --output "$newname"
}
alias nbx=__run_ipynb

