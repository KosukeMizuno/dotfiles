#### .ZPROFILE ####
# Executes commands at login pre-zshrc.

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='nvim'
export VISUAL='nano'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

# LESS
export LESS='-g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# dotfiles
export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
source "$DOTPATH/sh/path.sh"

# suppress stopping on ssh
stty stop undef

# enable direnv
eval "$(direnv hook zsh)"

# load local bash_profile if exists
if [ -f "$HOME/.sh_profile_local" ]; then
    source "$HOME/.sh_profile_local"
fi

# load secure things if exists
if [ -f "$HOME/.sh_secure" ]; then
    source "$HOME/.sh_secure"
fi
