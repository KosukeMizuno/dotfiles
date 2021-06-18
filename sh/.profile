#### .PROFILE ####
# This file is sourced at starting Ubuntu-Desktop.
# shellcheck disable=SC2148,SC1091

export DOTPATH="${DOTPATH:-$HOME/dotfiles}"

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
