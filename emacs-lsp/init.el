;;; init.el --- Full IDE configuration for Idris2 with LSP -*- lexical-binding: t; -*-

;;; Commentary:
;; Complete IDE setup with LSP, completion, UI enhancements, and project navigation

;;; Code:

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Import MELPA key to Emacs GPG keyring
(setq package-gnupghome-dir (expand-file-name "elpa/gnupg" user-emacs-directory))
(unless (file-directory-p package-gnupghome-dir)
  (make-directory package-gnupghome-dir t))

(package-initialize)

;; Install required packages for full IDE experience
(dolist (pkg '(lsp-mode lsp-docker lsp-ui lsp-treemacs 
               company which-key treemacs prop-menu))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

;;; Core LSP Configuration
(setq lsp-log-io t)
(setq lsp-docker-log-docker-supplemental-calls t)

;;; Company Mode - Completion
(require 'company)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)  ; Instant completion
(add-hook 'lsp-mode-hook #'company-mode)

;;; LSP UI - Visual Enhancements
(require 'lsp-ui)
(setq lsp-ui-sideline-show-diagnostics t
      lsp-ui-sideline-show-hover t
      lsp-ui-sideline-show-code-actions t
      lsp-ui-sideline-update-mode 'line
      lsp-ui-sideline-delay 0.2
      lsp-ui-doc-enable t
      lsp-ui-doc-position 'at-point
      lsp-ui-doc-delay 0.5
      lsp-ui-doc-show-with-cursor t
      lsp-ui-peek-enable t
      lsp-ui-peek-show-directory t)

;;; LSP Treemacs - Project Navigation
(require 'lsp-treemacs)
(lsp-treemacs-sync-mode 1)  ; Sync workspace folders with treemacs

;;; Modeline & Headerline
(setq lsp-modeline-diagnostics-enable t
      lsp-modeline-diagnostics-scope :workspace
      lsp-modeline-code-actions-enable t
      lsp-headerline-breadcrumb-enable t
      lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))

;;; Code Lens & Formatting
(setq lsp-lens-enable t
      lsp-enable-on-type-formatting t
      lsp-format-buffer-on-save nil)  ; Disable auto-format, use manual

;;; Symbol Highlighting
(setq lsp-enable-symbol-highlighting t)

;;; Which-key for keybinding discovery
(require 'which-key)
(which-key-mode 1)
(setq which-key-idle-delay 0.5)

;;; Load idris2-mode from local clone
(add-to-list 'load-path "/home/zak/idris2-dev/emacs-lsp/idris2-mode")
(require 'idris2-mode)

;;; Load Idris2 LSP configuration
(load-file "/home/zak/idris2-dev/emacs-lsp/idris2-lsp.el")

;;; Load custom keybindings
(load-file "/home/zak/idris2-dev/emacs-lsp/lsp-bindings.el")

;;; Enable modes in LSP buffers
(add-hook 'lsp-mode-hook #'lsp-ui-mode)
(add-hook 'lsp-mode-hook #'lsp-modeline-diagnostics-mode)
(add-hook 'lsp-mode-hook #'lsp-modeline-code-actions-mode)
(add-hook 'lsp-mode-hook #'lsp-headerline-breadcrumb-mode)

(provide 'init)
;;; init.el ends here

