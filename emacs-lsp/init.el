;; LSP Mode Configuration for idris2-lsp Container Connection

(condition-case err
    (progn
      (require 'lsp-mode)
      (message "lsp-mode loaded successfully")
      
      ;; Define minimal idris2 major mode
      (define-derived-mode idris2-mode prog-mode "Idris2"
        "Major mode for Idris2 files.")
      
      ;; Register LSP client using standard idris2-lsp command
      ;; The idris2-lsp "binary" is actually a wrapper script that uses netcat
      (lsp-register-client
       (make-lsp-client 
        :new-connection (lsp-stdio-connection "idris2-lsp")
        :major-modes '(idris2-mode)
        :server-id 'idris2-lsp
        :remote? t))
      
      ;; Language ID mapping
      (add-to-list 'lsp-language-id-configuration '(idris2-mode . "idris2"))
      
      ;; File extension mapping
      (add-to-list 'auto-mode-alist '("\\.idr\\'" . idris2-mode))
      
      ;; Auto-activation
      (add-hook 'idris2-mode-hook #'lsp))
  (error (message "lsp-mode failed to load: %s" (error-message-string err))))
