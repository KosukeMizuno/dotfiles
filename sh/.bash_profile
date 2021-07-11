#### BASH_PROFILE ####
# shellcheck disable=SC1090,SC1091,SC2148

# zshの起動を抑制したい場合は DISABLE_AUTO_ZSH を設定すること
if [[ -z $DISABLE_AUTO_ZSH ]]; then
    if [[ -z $BASH_EXECUTION_STRING ]]; then
        ZSHEXE="${PREFIX:-$HOME/.local}/bin/zsh"
        [[ -x $ZSHEXE ]] && SHELL="$ZSHEXE" exec "$ZSHEXE" -l
    fi
fi

# dotfiles
export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
source "$DOTPATH/sh/path.sh"

# suppress stopping on ssh
stty stop undef

# enable direnv
[[ -n $(command -v direnv) ]] && eval "$(direnv hook bash)"

# load local bash_profile if exists
if [[ -e "$HOME/.sh_profile_local" ]]; then
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
