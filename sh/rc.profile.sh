
export DOTPATH="$HOME/dotfiles"
source "$DOTPATH/bin/lazyenv.bash"

#### USER PREFIX
export PREFIX="$HOME/.local"
export PATH="$PREFIX/bin:$PATH"
export LD_LIBRARY_PATH="$PREFIX/lib64:$PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

#### FZF
source $PREFIX/opt/fzf/shell/completion.bash
source $PREFIX/opt/fzf/shell/key-bindings.bash

#### PYTHON
# poetry
export PATH="$HOME/.poetry/bin:$PATH"

#### RUST
export PATH="$HOME/.cargo/bin:$PATH"



