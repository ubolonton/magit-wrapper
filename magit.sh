#!/bin/sh
# Dir that the script is stored
# echo "$( readlink "$( basename "$0" )" )"
# echo "$( cd "$( dirname "$0" )" && pwd -P )"
BASE_DIR="$( dirname "$( readlink -f "$0" )")"

# 256 colors mean better-looking theme
env TERM=xterm-256color COGINI_EMACS=$BASE_DIR emacs -nw -q --no-splash -l $BASE_DIR/init.el

