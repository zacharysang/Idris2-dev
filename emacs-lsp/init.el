;; Minimal init.el for local emacs with idris2-lsp container

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Import MELPA key to Emacs GPG keyring
(setq package-gnupghome-dir (expand-file-name "elpa/gnupg" user-emacs-directory))
(unless (file-directory-p package-gnupghome-dir)
  (make-directory package-gnupghome-dir t))

(package-initialize)

;; Install required packages
(dolist (pkg '(lsp-mode lsp-docker prop-menu))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

;; Enable LSP logging for debugging
(setq lsp-log-io t)
(setq lsp-docker-log-docker-supplemental-calls t)

;; Load idris2-mode from local clone
(add-to-list 'load-path "/home/zak/idris2-dev/emacs-lsp/idris2-mode")
(require 'idris2-mode)

;; Load Idris2 LSP configuration
(load-file "/home/zak/idris2-dev/emacs-lsp/idris2-lsp.el")

