;; idris2-lsp.el - lsp-docker configuration for Idris2

(require 'lsp-mode)
(require 'lsp-docker)

;; Register base idris2-lsp client
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection "idris2-lsp")
  :major-modes '(idris2-mode)
  :server-id 'idris2-lsp))

;; Auto-register docker config from .lsp-docker.yml when opening idris2 files
(defun idris2-lsp-docker-setup ()
  "Load .lsp-docker.yml config if present in project root"
  (when (and (lsp-workspace-root)
             (file-exists-p (expand-file-name ".lsp-docker.yml" (lsp-workspace-root))))
    (lsp-docker-register)))

(add-hook 'idris2-mode-hook #'idris2-lsp-docker-setup)
(add-hook 'idris2-mode-hook #'lsp-deferred)

(provide 'idris2-lsp)
