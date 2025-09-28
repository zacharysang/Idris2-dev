#!/bin/bash

# Move current init.el to backup
mv ~/.emacs.d/init.el ~/.emacs.d/init.el.original

# Create symlink from emacs-lsp/init.el to ~/.emacs.d/init.el
ln -s "$(pwd)/init.el" ~/.emacs.d/init.el

echo "Emacs configuration switched to emacs-lsp setup"
