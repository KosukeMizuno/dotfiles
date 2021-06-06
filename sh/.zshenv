##### ZSHENV ####

export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
export ZDOTDIR="${ZDOTDIR:-$DOTPATH/sh}"

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
  source "$ZDOTDIR/.zprofile"
fi