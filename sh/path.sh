#### rc.env.sh ####
# setup enviromnental variables related with PATH
# shellcheck disable=SC2148,SC1091

# asdf
[[ -e "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

# user built things
export PREFIX="${PREFIX:-$HOME/.local}"
export PATH="$PREFIX/bin:$PATH"
LD_LIBLARY_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_LIBLARY_PATH" | sed 's/:$//')
LD_RUN_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_RUN_PATH" | sed 's/:$//')
PKG_CONFIG_PATH=$(echo "$PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" | sed 's/:$//')
export LD_LIBLARY_PATH LD_RUN_PATH PKG_CONFIG_PATH

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

# GOLANG
export GOPATH="$PREFIX/opt/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# PYTHON
export PYTHON_VENV_DIR="${PYTHON_VENV_DIR:-$HOME/venvs}"
export PYTHON_DEFAULT_VENV="${PYTHON_DEFAULT_VENV:-$PYTHON_VENV_DIR/default}"
export PATH="$HOME/.poetry/bin:$PATH"
if [[ -e "$PYTHON_DEFAULT_VENV/bin/activate" ]]; then
    source "$PYTHON_DEFAULT_VENV/bin/activate"
elif [[ -e "$PYTHON_DEFAULT_VENV/Script/activate" ]]; then
    source "$PYTHON_DEFAULT_VENV/Script/activate"
fi
