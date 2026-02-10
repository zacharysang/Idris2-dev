#!/bin/bash
# Test script to open Tutorial.idr and capture LSP logs

cd /home/zak/idris2-dev/idris2-tutorial

# Launch Emacs with the Tutorial.idr file
emacs --eval "(progn
  (add-to-list 'load-path \"~/idris2-dev/emacs-lsp\")
  (require 'idris2-lsp)
  (find-file \"~/idris2-dev/idris2-tutorial/src/Tutorial.idr\")
  (sit-for 5)
  (with-current-buffer \"*Messages*\"
    (write-file \"/tmp/emacs-messages.log\"))
  (when (get-buffer \"*lsp-log*\")
    (with-current-buffer \"*lsp-log*\"
      (write-file \"/tmp/lsp-log.log\")))
  (message \"Logs saved. Check docker ps for containers.\")
  (sit-for 2))"
