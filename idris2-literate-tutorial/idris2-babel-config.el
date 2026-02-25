;; Idris2 Babel configuration

(defun org-babel-execute:idris2 (body params)
  "Execute Idris2 code block using Docker containers."
  (let ((cmd (or (cdr (assoc :cmd params))
                 "../idris2-docker-repl/run.sh")))
    (org-babel-eval cmd body)))

;; Load shell support (used by Docker commands)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)))

;; Don't prompt for confirmation
(setq org-confirm-babel-evaluate nil)
