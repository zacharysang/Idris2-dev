;;; lsp-bindings.el --- Idiomatic keybindings for LSP IDE features -*- lexical-binding: t; -*-

;;; Commentary:
;; Provides idiomatic Emacs keybindings for LSP features
;; Organized by functionality with which-key integration

;;; Code:

(require 'lsp-mode)

;;; Simple bindings for common operations
(define-key lsp-mode-map (kbd "M-.") #'lsp-find-definition)
(define-key lsp-mode-map (kbd "M-?") #'lsp-find-references)
(define-key lsp-mode-map (kbd "M-RET") #'lsp-execute-code-action)
(define-key lsp-mode-map (kbd "C-c d") #'lsp-describe-thing-at-point)
(define-key lsp-mode-map (kbd "C-c r") #'lsp-rename)

;; Navigation (C-c l g prefix)
(define-key lsp-mode-map (kbd "C-c l g d") #'lsp-find-definition)
(define-key lsp-mode-map (kbd "C-c l g r") #'lsp-find-references)
(define-key lsp-mode-map (kbd "C-c l g i") #'lsp-find-implementation)
(define-key lsp-mode-map (kbd "C-c l g t") #'lsp-find-type-definition)
(define-key lsp-mode-map (kbd "C-c l g D") #'lsp-find-declaration)

;; Peek (C-c l p prefix) - requires lsp-ui
(when (featurep 'lsp-ui)
  (define-key lsp-mode-map (kbd "C-c l p d") #'lsp-ui-peek-find-definitions)
  (define-key lsp-mode-map (kbd "C-c l p r") #'lsp-ui-peek-find-references)
  (define-key lsp-mode-map (kbd "C-c l p i") #'lsp-ui-peek-find-implementation)
  (define-key lsp-mode-map (kbd "C-c l p s") #'lsp-ui-peek-find-workspace-symbol))

;; Documentation (C-c l h prefix)
(define-key lsp-mode-map (kbd "C-c l h h") #'lsp-describe-thing-at-point)
(define-key lsp-mode-map (kbd "C-c l h s") #'lsp-signature-activate)

;; Refactoring (C-c l r prefix)
(define-key lsp-mode-map (kbd "C-c l r r") #'lsp-rename)
(define-key lsp-mode-map (kbd "C-c l r o") #'lsp-organize-imports)
(define-key lsp-mode-map (kbd "C-c l r f") #'lsp-format-buffer)
(define-key lsp-mode-map (kbd "C-c l r R") #'lsp-format-region)

;; Code actions (C-c l a prefix)
(define-key lsp-mode-map (kbd "C-c l a a") #'lsp-execute-code-action)
(define-key lsp-mode-map (kbd "C-c l a l") #'lsp-avy-lens)
(define-key lsp-mode-map (kbd "C-c l a h") #'lsp-document-highlight)

;; Workspace (C-c l w prefix)
(define-key lsp-mode-map (kbd "C-c l w s") #'lsp)
(define-key lsp-mode-map (kbd "C-c l w r") #'lsp-workspace-restart)
(define-key lsp-mode-map (kbd "C-c l w q") #'lsp-workspace-shutdown)
(define-key lsp-mode-map (kbd "C-c l w d") #'lsp-describe-session)

;; Toggles (C-c l t prefix)
(define-key lsp-mode-map (kbd "C-c l t l") #'lsp-lens-mode)
(define-key lsp-mode-map (kbd "C-c l t h") #'lsp-toggle-symbol-highlight)
(define-key lsp-mode-map (kbd "C-c l t f") #'lsp-toggle-on-type-formatting)
(define-key lsp-mode-map (kbd "C-c l t s") #'lsp-toggle-signature-auto-activate)
(define-key lsp-mode-map (kbd "C-c l t L") #'lsp-toggle-trace-io)

;; Treemacs integration (C-c l T prefix) - requires lsp-treemacs
(when (featurep 'lsp-treemacs)
  (define-key lsp-mode-map (kbd "C-c l T e") #'lsp-treemacs-errors-list)
  (define-key lsp-mode-map (kbd "C-c l T s") #'lsp-treemacs-symbols)
  (define-key lsp-mode-map (kbd "C-c l T r") #'lsp-treemacs-references)
  (define-key lsp-mode-map (kbd "C-c l T i") #'lsp-treemacs-implementations)
  (define-key lsp-mode-map (kbd "C-c l T c") #'lsp-treemacs-call-hierarchy)
  (define-key lsp-mode-map (kbd "C-c l T t") #'lsp-treemacs-type-hierarchy))

;; UI toggles (C-c l u prefix) - requires lsp-ui
(when (featurep 'lsp-ui)
  (define-key lsp-mode-map (kbd "C-c l u s") #'lsp-ui-sideline-mode)
  (define-key lsp-mode-map (kbd "C-c l u d") #'lsp-ui-doc-mode)
  (define-key lsp-mode-map (kbd "C-c l u i") #'lsp-ui-imenu))

;; Enable which-key integration
(with-eval-after-load 'which-key
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

(provide 'lsp-bindings)
;;; lsp-bindings.el ends here
