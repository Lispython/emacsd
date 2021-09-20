;; DEFIN VARIABLES
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;IPYTHON MODE
;(setq ipython-command "~/.emacs.d/venv/bin/ipython")
;(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

;(setq py-shell-name "~/.emacs.d/venv/bin/ipython")

;(setq py-block-comment-prefix "#")

(setq docker-container-name "emacsd")

(defsubst string-join (strings &optional separator)
  "Join all STRINGS using SEPARATOR."
  (mapconcat 'identity strings separator))




;; PYTHON DEBUGGING
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()")
  (highlight-lines-matching-regexp "import rpdb2")
  (highlight-lines-matching-regexp "rpdb2.start_embedded_debugger("))

(defun python-add-breakpoint ()
  (interactive)
  ;; (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))


(defun ipdb-cleanup ()
  (interactive)
  (save-excursion
    (replace-regexp ".*ipdb.set_trace().*\n" "" nil (point-min) (point-max))
    ;; (save-buffer)
    ))


(defun python-mode-hook-callback ()
  (message "python mode hook")
  (annotate-pdb)
  (lambda-mode)
  ;; (ac-ropemacs-initialize)
  ;;TODO: use virtualenv version
  ;;(setq pymacs-python-command py-python-command)
  ;;(set-variable 'py-indent-offset 4)
  ;;(set-variable 'py-smart-indentation nil)
  ;;(set-variable 'indent-tabs-mode nil)
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))

  (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
  )

(use-package lambda-mode
  :hook (python-mode . lambda-mode))

;; (use-package python-mode
;;   :bind (("C-c C-t" . python-add-breakpoint))
;;   :bind-keymap (("C-c C-t" . python-add-breakpoint))
;;   :init (progn (add-hook 'python-mode-hook 'annotate-pdb)
;;                (message "Use package python-mode init"))
;;   :config (progn (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
;;                  ;; (setq ipython-command "~/.emacs.d/venv/bin/ipython")
;;                  ;; (setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")
;;                  ;; (setq py-shell-name "~/.emacs.d/venv/bin/ipython")

;;                  ;; ;; (require 'pyenv-mode)
;;                  ;; ;; (require 'pyenv-mode-auto)

;;                  ;; ;; KEY MAPS DEFINITIONS
;;                  ;; (define-key python-mode-map "\t" 'ryan-python-tab)
;;                  ;; (define-key python-mode-map (kbd "RET") 'newline-and-indent)
;;                  ;; ;;(define-key py-mode-map (kbd "C-c l") 'pylookup-lookup)
;;                  ;;                        ;(define-key python-mode-map [tab] 'yas/expand)
;;                  ;;  (define-key python-mode-map "\t" 'smart-tab)

;;                  ;; (add-hook 'python-mode-hook (lambda () (exec-path-from-shell-copy-env "PYTHONPATH")))
;;                  )

;;   :hook (python-mode . python-mode-hook-callback))







(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))

    (with-temp-message (format "Switching projectile project to: %s" projectile-project-name))

    ;; (if (member project (pyenv-mode-versions))
    ;;     (pyenv-mode-set project)
    ;;   (pyenv-mode-unset))

    ))


;; (defun guess-python-version ()
;;   "Try to guess python pytenv."
;;   (with-temp-message (format "Try to guess python version"))
;;   (require 'auto-virtualenv)
;;   (let ((path (auto-virtualenv-find-virtualenv-path)))
;;     (message (format "Activated virtualenv: %s" path))
;;     )
;;   (message (format "python-shell-virtualenv-root=%s" python-shell-virtualenv-root))
;;   )

(defun print-python-vars ()
  "print python vars"
  (message "print-python-vars")
  (message (format "local variable python-shell-virtualenv-root=%s" python-shell-virtualenv-root))
  )


;; (add-hook 'python-mode-hook 'guess-python-version)

;; (add-hook 'hack-local-variables-hook 'print-python-vars)
;; (add-hook 'before-save-hook 'print-python-vars)


(use-package python-mode
  :ensure t
  :config (progn

            (auto-complete-mode t)
            (annotate-pdb)
            (lambda-mode)

            (add-hook 'python-mode-hook 'python-mode-hook-callback)
            (add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)

            (exec-path-from-shell-copy-env "PYTHONPATH")

            )
  )

(require 's)
            (require 'f)

(use-package pyenv-mode
  :ensure t
  :init
  (add-to-list 'exec-path "~/.pyenv/shims")
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  :config (progn
            (setq pyenv-show-active-python-in-modeline t)
            (pyenv-mode)


            (require 'pyenv-mode)

            (defun pyenv-mode-auto-hook ()
              "Automatically activates pyenv version if .python-version file exists."
              (f-traverse-upwards
               (lambda (path)
                 (let ((pyenv-version-path (f-expand ".python-version" path)))
                   (if (f-exists? pyenv-version-path)
                       (progn
                         (pyenv-mode-set (car (s-lines (s-trim (f-read-text pyenv-version-path 'utf-8)))))
                         t))))))

            (add-hook 'find-file-hook 'pyenv-mode-auto-hook)

            )
  ;; :bind ("C-x p e" . pyenv-activate-current-project)
  )


(defun pythonic-activate (virtualenv)
  "Activate python VIRTUALENV and set local version of python-shell-virtualenv-root"
  (interactive "DEnv: ")
  (with-temp-message (format "pythonic-activate set local virtualenv"))
  (setq-local python-shell-virtualenv-root (pythonic-python-readable-file-name virtualenv)))

;;;###autoload
(defun pythonic-deactivate ()
  "Deactivate python virtual environment."
  (interactive)
  (with-temp-message (format "pythonic-activate remove local virtualenv"))
  (setq-local python-shell-virtualenv-root nil))
  (kill-local-variable python-shell-virtualenv-root)

(use-package pip-requirements
  :ensure t
  )


(use-package reformatter
  :ensure t
  :config (progn
            ;; TODO make dynamic avaluation
            (setq pep8-command "autopep8"
                  isort-command "isort")

            (reformatter-define py-autopep8-format
              :program "autopep8"
              :args '("--max-line-length=200" "-"))

            (reformatter-define py-imports-format
              :program "isort"
              :args (list "--lines=100" (concat "-sp=" (projectile-project-root)) "-"))

            (reformatter-define py-yapf-format
              :program "yapf"
              :args (list "--style=pep8"))

            (reformatter-define py-hash-replace
              :program "sed"
              :args (list "s/\s*\#\s*$//g"))

            ))


(provide 'python-mode-dockerized-init)
;;; python-mode-init.el ends here
