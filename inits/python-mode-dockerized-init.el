;;; python-mode-dockerized-init.el ---

;;; Commentary:
;;

(require 's)
(require 'f)

;; DEFIN VARIABLES
;;; Code:

(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;IPYTHON MODE
;(setq ipython-command "~/.emacs.d/venv/bin/ipython")
;(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")


(setq docker-container-name "emacsd")

(defsubst string-join (strings &optional separator)
  "Join all STRINGS using SEPARATOR."
  (mapconcat 'identity strings separator))




;; PYTHON DEBUGGING
(defun annotate-pdb ()
  ""
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()")
  (highlight-lines-matching-regexp "import rpdb2")
  (highlight-lines-matching-regexp "rpdb2.start_embedded_debugger("))

(defun python-add-breakpoint ()
  ""
  (interactive)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))


(defun ipdb-cleanup ()
  ""
  (interactive)
  (save-excursion
    (replace-regexp ".*ipdb.set_trace().*\n" "" nil (point-min) (point-max))
    ;; (save-buffer)
    ))


(defun python-mode-hook-callback ()
  ""
  (annotate-pdb)
  (lambda-mode)
  (setq python-indent-offset 4)

  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))

  (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint))

(use-package lambda-mode
  :hook (python-mode . lambda-mode))


(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))
    (message (format "Switching projectile project to: %s" projectile-project-name))
    ))


(defun print-python-vars ()
  "print python vars"
  (message "print-python-vars ---------------")
  (message (format "local variable python-shell-virtualenv-root=%s" python-shell-virtualenv-root))
  (dolist (item process-environment)
    (message (format "VAR => %s" item))
    )
  (message "print-python-vars-end ---------------")

  )


(use-package python-mode
  :ensure t
  :bind (("C-c C-t" . python-add-breakpoint))
  :config (progn
            (setq python-indent-offset 4)

            (auto-complete-mode t)
            (annotate-pdb)
            (lambda-mode)

            (add-hook 'python-mode-hook 'python-mode-hook-callback)
            (add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)

            (exec-path-from-shell-copy-env "PYTHONPATH")
            )
  )



(defun pyenv-mode-auto-hook ()
  "Automatically activates pyenv version if .python-version file exists."
  (f-traverse-upwards
   (lambda (path)
     (let ((pyenv-version-path (f-expand ".python-version" path)))
       (if (f-exists? pyenv-version-path)
           (progn
             (pyenv-mode-set (car (s-lines (s-trim (f-read-text pyenv-version-path 'utf-8)))))
             t))))))

(defun pyenv-activate-hook ()
  ""
  (make-local-variable 'process-environment)

  (make-local-variable 'python-shell-virtualenv-root)

  (pyenv-mode-auto-hook)

  )

(use-package pyenv-mode
  :ensure t
  :init
  (add-to-list 'exec-path "~/.pyenv/shims")
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  :config (progn
            ;; (setq pyenv-show-active-python-in-modeline t)
            (pyenv-mode)
            (add-hook 'find-file-hook 'pyenv-activate-hook)
            )
  ;; :bind ("C-x p e" . pyenv-activate-current-project)
  )


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

;;; python-mode-dockerized-init.el ends here
