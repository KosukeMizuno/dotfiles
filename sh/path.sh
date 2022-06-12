#### rc.env.sh ####
# setup enviromnental variables related with PATH
# shellcheck disable=SC2148,SC1091

export PREFIX="${PREFIX:-$HOME/.local}"

# asdf
[[ -e "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

# GOLANG
export GOPATH="$PREFIX/opt/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# user built things
export PATH="$PREFIX/bin:$PATH"
LD_LIBRARY_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_LIBRARY_PATH" | sed 's/:$//')
LD_RUN_PATH=$(echo "$PREFIX/lib64:$PREFIX/lib:$LD_RUN_PATH" | sed 's/:$//')
PKG_CONFIG_PATH=$(echo "$PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH" | sed 's/:$//')
export LD_LIBRARY_PATH LD_RUN_PATH PKG_CONFIG_PATH

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# PYTHON
: PYTHONUTF8=${PYTHONUTF8=1}
export PYTHON_VENV_DIR="${PYTHON_VENV_DIR:-$HOME/venvs}"
export PYTHON_DEFAULT_VENV="${PYTHON_DEFAULT_VENV:-$PYTHON_VENV_DIR/default}"
export PATH="$HOME/.poetry/bin:$PATH"
if "${USE_ANACONDA:-false}" && [[ -e "$PATH_CONDA_SH" ]]; then
    source "$PATH_CONDA_SH"
    [[ -n "$DEFAULT_ENV_CONDA" ]] && conda activate "$DEFAULT_ENV_CONDA"
else
    if [[ -e "$PYTHON_DEFAULT_VENV/bin/activate" ]]; then
        source "$PYTHON_DEFAULT_VENV/bin/activate"
    elif [[ -e "$PYTHON_DEFAULT_VENV/Scripts/activate" ]]; then
        source "$PYTHON_DEFAULT_VENV/Scripts/activate"
    fi
fi

# PATH for each environments
if $("$IS_WSL"); then
    export PATH="$DOTPATH/wsl_ubuntu/bin:$PATH"
fi

