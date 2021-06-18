#### ZSHRC: Setup prezto & p10k ####

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#### ZSHRC ####

# echo "Sourcing zshrc"

# common
source "$DOTPATH/sh/common.sh"

# alias
source "$DOTPATH/sh/alias.sh"

# load local bashrc
if [ -f "$HOME/.shrc_local" ]; then
	source "$HOME/.shrc_local"
fi

#### custom keybindings
# reload rc with Crtl+X Ctrl+R
function __source_rc() {
    local BUF=$BUFFER
    zle kill-whole-line
    BUFFER=rc
    zle .accept-line
    if [[ ! ${#BUF} -eq 0 ]];then
        zle -U ${BUF}
    fi
}
zle -N __source_rc
bindkey "^x^r" __source_rc

# Ctrl+Z で最後のジョブを復帰させる
## https://qiita.com/uasi/items/93846fb0a671c0f1cc05
function __run_fglast {
    zle push-input
    BUFFER="fg %"
    zle accept-line
}
zle -N __run_fglast
bindkey "^z" __run_fglast

# 履歴から補完する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# 履歴に残さないコマンドを指定
HISTORY_IGNORE_COMMAND="cd|pwd|ls|ll|la|lla|x|rm|mv|gomi|exit|rc|fg"
HISTORY_IGNORE_GIT="gc|gcm|gcam|gf|gs|ga|gl|gd|gp|grj|grs|gj|gx"
HISTORY_IGNORE_EDITOR="nano|vim|nvim|code|editor_or_fg"
export HISTORY_IGNORE="($HISTORY_IGNORE_EDITOR|$HISTORY_IGNORE_GIT|$HISTORY_IGNORE_COMMAND)"

# Ctrl+r で履歴から検索 with fzf
function select-history() {
    BUFFER=$(history -n -r 1 | FZF_DEFAULT_OPTS="" fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# テキストエディタを Ctrl+x Ctrl+j で呼び出す
# suspended job に居たら新しく立ち上げずそちらを起動
editor_or_fg (){
    EDITOR_PROG=${EDITOR:-nvim}
    if [[ $# -gt 0 ]]; then
        # 引数がある場合はそのまま渡して起動
        $EDITOR_PROG "$@"
    elif [[ $(jobs | grep $EDITOR_PROG | wc -l) == 1 ]] ; then
        # 引数なしかつsuspended jobに$EDITOR_PROGがある場合はfgで呼び戻す
        JOBID=$(jobs -s | grep $EDITOR_PROG | sed -r 's/^\[([0-9]+)\].*$/\1/')
        fg "%$JOBID"
    else
        # 普通に起動する
        $EDITOR_PROG
    fi
}
function __editor_or_fg {
    zle push-input
    BUFFER="editor_or_fg"
    zle accept-line
}
zle -N __editor_or_fg
bindkey "^x^j" __editor_or_fg
alias nvim=editor_or_fg


#### PROFILING ####
if [[ -n ${ZSH_DO_PROFILING:-} ]]; then
    if (which zprof > /dev/null 2>&1) ; then
        zprof
    fi
fi

# vim: set ft=sh :