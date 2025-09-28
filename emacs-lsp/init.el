;; LSP Mode Configuration for idris2-lsp Container Connection

;; Initialize packages first
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install idris-mode if not already installed
(unless (package-installed-p 'idris-mode)
  (package-refresh-contents)
  (package-install 'idris-mode))

;; Configure idris-mode (outside try-catch to ensure it runs)
(require 'idris-mode)
(customize-set-variable 'idris-interpreter-path "/home/zak/.pack/bin/idris2")
(message "Set idris-interpreter-path to: %s" idris-interpreter-path)

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
      (setq lsp-keymap-prefix "C-c l"))
  (error (message "lsp-mode failed to load: %s" (error-message-string err))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(idris-mode cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
