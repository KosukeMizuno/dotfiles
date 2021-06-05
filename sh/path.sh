#### rc.env.sh ####
# setup enviromnental variables related with PATH

# user built things
export PREFIX="${PREFIX:-$HOME/.local}"
export PATH="$PREFIX/bin:$PATH"
export LD_LIBLARY_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_LIBLARY_PATH" | sed 's/:$//')
export LD_RUN_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_RUN_PATH" | sed 's/:$//')
export PKG_CONFIG_PATH=$(echo "$PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" | sed 's/:$//')

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# asdf
[ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

# PYTHON
export PYTHON_DEFAULT_VENV="${PYTHON_DEFAULT_VENV:-$HOME/.venv_default}"
export PATH="$HOME/.poetry/bin:$PATH"

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

#### COMPLETION ####
# # lazyloader
# source "$DOTPATH/bin/lazyenv.bash"
#
# # fzf
# source $PREFIX/opt/fzf/shell/completion.bash
# source $PREFIX/opt/fzf/shell/key-bindings.bash
#
