;; LSP Mode Configuration for idris2-lsp Container Connection

;; Initialize packages first
(require 'package)
(package-initialize)

(condition-case err
    (progn
      (require 'lsp-mode)
      (message "lsp-mode loaded successfully")
      
      ;; Enable comprehensive LSP debugging
      (setq lsp-log-io t)
      (setq lsp-trace t)
      (setq lsp-print-performance t)
      (setq lsp-log-max 1000)
      (setq lsp-enable-file-watchers nil)
      (setq lsp-tcp-connection-timeout 30)
      (setq lsp-response-timeout 30)
      
      ;; Set LSP keymap prefix (C-c l to avoid conflict with M-l downcase)
      (setq lsp-keymap-prefix "C-c l")
       
      ;; Define minimal idris2 major mode
      (define-derived-mode idris2-mode prog-mode "Idris2"
        "Major mode for Idris2 files.")
      
      ;; Register LSP client using standard idris2-lsp command
      ;; The idris2-lsp "binary" is actually a wrapper script that uses netcat
      ;; idris2-lsp configuration options: https://github.com/idris-community/idris2-lsp?tab=readme-ov-file#configuration-options
      ;; lsp-mode initialization-options: https://github.com/emacs-lsp/lsp-mode/blob/1b13d7c1b39aaad12073095ef7719952568c45db/lsp-mode.el#L1623
      (lsp-register-client
       (make-lsp-client 
        :new-connection (lsp-stdio-connection "idris2-lsp")
        :major-modes '(idris2-mode)
        :server-id 'idris2-lsp
        :remote? t
        :initialization-options (lambda ()
                                  '(:maxCodeActionResults 20
                                    :showImplicits t))))
      
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
