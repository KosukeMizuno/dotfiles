#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
export LESS='-g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi


#### こっからした自分の
# TODO: 上の部分を整理する
echo "Loading bash_profile"

# dotfiles
export DOTPATH="${DOTPATH:-$HOME/dotfiles}"
source "$DOTPATH/sh/path.sh"

# load local bash_profile if exists
if [ -f "$HOME/.bash_profile_local" ]; then
    source "$HOME/.sh_profile_local"
fi

# load secure things if exists
if [ -f "$HOME/.sh_secure" ]; then
    source "$HOME/.sh_secure"
fi

# load bashrc
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# enable completion
# TODO: 遅いのでlazyloadingさせる
source "$DOTPATH/sh/completion.sh"
