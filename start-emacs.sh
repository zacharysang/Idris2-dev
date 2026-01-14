#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <project-path>"
    exit 1
fi

./idris2-lsp/run.sh "$1"
exec emacs --debug-init -l /home/zak/idris2-dev/emacs-lsp/init.el
