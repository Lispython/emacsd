;; DEFIN VARIABLES
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;IPYTHON MODE
(setq ipython-command "~/.emacs.d/venv/bin/ipython")
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

(setq py-shell-name "~/.emacs.d/venv/bin/ipython")

(setq py-block-comment-prefix "#")

;; PYTHON DEBUGGING
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()")
  (highlight-lines-matching-regexp "import rpdb2")
  (highlight-lines-matching-regexp "rpdb2.start_embedded_debugger("))

(defun python-add-breakpoint ()
  (interactive)
  (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))


;; KEY MAPS DEFINITIONS
(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
(define-key py-mode-map "\t" 'ryan-python-tab)
(define-key py-mode-map (kbd "RET") 'newline-and-indent)
(define-key py-mode-map (kbd "C-c l") 'pylookup-lookup)
;(define-key py-mode-map [tab] 'yas/expand)
(define-key py-mode-map "\t" 'smart-tab)

;; HOOKS
(add-hook 'python-mode-hook
          (lambda ()
            (message "python mode hook")
            (auto-complete-mode t)
            (annotate-pdb)
            (lambda-mode)
            (flycheck-mode)
            (ac-ropemacs-initialize)
            ;;TODO: use virtualenv version
            ;;(setq pymacs-python-command py-python-command)
            (set-variable 'py-indent-offset 4)
            (set-variable 'py-smart-indentation nil)
            (set-variable 'indent-tabs-mode nil)
            (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))
            ))

(setq virtualenv-workon-home (getenv "PYENV_WORKON_HOME"))

;; Python or python mode?
(eval-after-load 'python
  '(progn
     ;;==================================================
     ;; Ropemacs Configuration
     ;;==================================================
     ;;(setup-ropemacs)

     ;;==================================================
     ;; Virtualenv Commands
     ;;==================================================
     ;; (autoload 'virtualenv-activate "default"
     ;;   "Activate a Virtual Environment specified by PATH" t)

     ;; (autoload 'virtualenv-workon "default"
     ;;   "Activate a Virtual Environment present using virtualenvwrapper" t)
     )
  )


(setq pyenv-show-active-python-in-modeline t)

(load "python-mode-env.el")

(provide 'python-mode-init)
;;; python-mode-init.el ends here
