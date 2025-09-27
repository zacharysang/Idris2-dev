#!/bin/bash

# Health check for emacs-lsp container LSP connectivity
# Tests if Emacs can connect to idris2-lsp container and establish LSP session

echo "=== Testing Emacs LSP Connection to idris2-lsp ==="

# Create a temporary test file in the mounted project directory
TEST_FILE="/tmp/project/test.idr"
cat > "$TEST_FILE" << 'EOF'
module Test

hello : String
hello = "Hello, Idris2!"
EOF

# Test LSP connection using emacs in batch mode
# Initialize packages first, then load init.el
cd /tmp/project
echo "i" | timeout 30 emacs --batch \
  --eval "(progn (require 'package) (package-initialize))" \
  --load /home/user/.emacs.d/init.el \
  --eval "(progn
    (find-file \"$TEST_FILE\")
    (idris2-mode)
    (condition-case err
        (progn
          ;; Set default-directory to project root before calling lsp
          ;; LSP uses default-directory for project detection and root calculation
          (setq default-directory \"/tmp/project/\")
          (lsp)
          (sit-for 5)  ; Wait for LSP to initialize
          (if (lsp-workspaces)
              (progn
                (message \"SUCCESS: LSP session established\")
                (message \"Workspace: %s\" (lsp-workspaces))
                (kill-emacs 0))
            (progn
              (message \"FAILED: No LSP workspaces found\")
              (kill-emacs 1))))
      (error 
        (message \"ERROR: %s\" (error-message-string err))
        (kill-emacs 1))))"

EXIT_CODE=$?

# Clean up
rm -f "$TEST_FILE"

if [ $EXIT_CODE -eq 0 ]; then
    echo "Health check PASSED: Emacs successfully connected to idris2-lsp"
    exit 0
else
    echo "Health check FAILED: Emacs could not establish LSP connection"
    exit 1
fi
