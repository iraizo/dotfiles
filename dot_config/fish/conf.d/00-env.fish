set -g --unexport PAGER bat
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.bun/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.julia/bin"

set -gx CXX /usr/bin/clang++
set -gx CC /usr/bin/clang
set -g --unexport PAGER moor
set -g --unexport MANPAGER "moor --reformat"
set -e GIT_PAGER
