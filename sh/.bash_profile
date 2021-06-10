#### BASH_PROFILE ####

ZSHEXE="$PREFIX/bin/zsh"
[ -x "$ZSHEXE" ] && exec $ZSHEXE

# dotfiles
export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
source "$DOTPATH/sh/path.sh"

# suppress stopping on ssh
stty stop undef

# enable direnv
eval "$(direnv hook bash)"

# load local bash_profile if exists
if [[ -e "$HOME/.bash_profile_local" ]]; then
    source "$HOME/.sh_profile_local"
fi

# load secure things if exists
if [[ -e "$HOME/.sh_secure" ]]; then
    source "$HOME/.sh_secure"
fi

# load bashrc
if [[ -e "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi

# enable completion
# TODO: 遅いのでlazyloadingさせる
for sc in "$DOTPATH"/sh/bash_completion.d/*.bash; do
    source "$sc"
done
