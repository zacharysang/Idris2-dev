;; LSP Mode Configuration for idris2-lsp Container Connection

;; Initialize packages first
(require 'package)
(package-initialize)

(condition-case err
    (progn
      (require 'lsp-mode)
      (message "lsp-mode loaded successfully")
      
      ;; Set LSP keymap prefix
      (setq lsp-keymap-prefix "M-l")
       
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
      (add-hook 'idris2-mode-hook #'lsp)
      
      ;; Keybindings for idris2-lsp capabilities (browser-safe)
      (define-key idris2-mode-map (kbd "M-g d") 'lsp-find-definition)      ; Go to definition
      (define-key idris2-mode-map (kbd "M-g r") 'lsp-find-references)      ; Find references  
      (define-key idris2-mode-map (kbd "M-g i") 'lsp-find-implementation)  ; Go to implementation
      (define-key idris2-mode-map (kbd "M-h") 'lsp-describe-thing-at-point) ; Hover info
      (define-key idris2-mode-map (kbd "M-r") 'lsp-rename)                 ; Rename symbol
      (define-key idris2-mode-map (kbd "M-a") 'lsp-execute-code-action)    ; Code actions (case split, expr search, etc.)
      (define-key idris2-mode-map (kbd "M-f") 'lsp-format-buffer)          ; Format buffer
      (define-key idris2-mode-map (kbd "M-e") 'lsp-ui-flycheck-list))       ; Show errors
  (error (message "lsp-mode failed to load: %s" (error-message-string err))))
