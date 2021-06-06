##### ZSHENV ####

export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
export ZDOTDIR="${ZDOTDIR:-$DOTPATH/sh}"

# export ZSH_DO_PROFILING=""
if [ -n "${ZSH_DO_PROFILING:-}" ]; then
    zmodload zsh/zprof && zprof
fi

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi