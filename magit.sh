#!/bin/sh
# Dir that the script is stored
BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
# 256 colors mean better-looking theme
env TERM=xterm-256color COGINI_EMACS=$BASE_DIR emacs -nw -Q -l $BASE_DIR/init.el

