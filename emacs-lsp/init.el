;; Minimal init.el for local emacs with idris2-lsp container

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Import MELPA key to Emacs GPG keyring
(setq package-gnupghome-dir (expand-file-name "elpa/gnupg" user-emacs-directory))
(unless (file-directory-p package-gnupghome-dir)
  (make-directory package-gnupghome-dir t))

(package-initialize)

(unless (package-installed-p 'lsp-mode)
  (package-refresh-contents)
  (package-install 'lsp-mode))

(require 'lsp-mode)

;; Define idris2 major mode
(define-derived-mode idris2-mode prog-mode "Idris2")

;; Register LSP client for containerized idris2-lsp
(lsp-register-client
 (make-lsp-client 
  :new-connection (lsp-tcp-connection (lambda (_) '("localhost" 3030)))
  :major-modes '(idris2-mode)
  :server-id 'idris2-lsp))

;; File extension mapping
(add-to-list 'auto-mode-alist '("\\.idr\\'" . idris2-mode))

;; Auto-activation
(add-hook 'idris2-mode-hook #'lsp)

;; Open project if PROJECT_PATH is set
(when (getenv "PROJECT_PATH")
  (find-file (getenv "PROJECT_PATH")))
