#!/usr/bin/env python

import sys, os

path = os.path.realpath(sys.argv[0])
path = os.path.dirname(path)

# FIX
emacs = "emacs -nw"

os.system("env TERM=xterm-256color COGINI_EMACS=%(path)s %(emacs)s -q --no-splash -l %(path)s/init.el" %{
    "path": path,
    "emacs": emacs
})
