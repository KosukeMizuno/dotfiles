##### ZSHENV ####

export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
export ZDOTDIR="${ZDOTDIR:-$HOME}"
# Note: preztoのインストールフォルダが`ZDOTDIR/.zprezto`を仮定していて、
#       git-submoduleで入れると面倒なのでHOME下にいれることにした

# unique PATH
typeset -U path PATH

# export ZSH_DO_PROFILING=""
if [[ -n ${ZSH_DO_PROFILING:-} ]]; then
    zmodload zsh/zprof && zprof
fi

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi