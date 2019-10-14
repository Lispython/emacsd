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


(require 'lambda-mode)

;;(setq py-python-command-args '("-colors" "Linux"))
;;(setq py-python-command "/var/github/python2.6/bin/ipython")
;;(setq py-python-command "/var/github/python2.6/bin/python2.7")
;;(setq py-jython-command "/usr/bin/jython")
;;(defadvice py-execute-buffer (around python-keep-focus activate)
;; "return focus to python code buffer"
;; (save-excursion ad-do-it))

;; (defun setup-ropemacs ()
;;   "Setup the ropemacs harness"
;;   (setenv "PYTHONPATH"
;;           (concat
;;            (getenv "PYTHONPATH") path-separator
;;            (concat dotfiles-dir "python-libs/")))
;;   (pymacs-load "ropemacs" "rope-")

;;   ;; Stops from erroring if there's a syntax err
;;   (setq ropemacs-codeassist-maxfixes 3)
;;   (setq ropemacs-guess-project t)
;;   (setq ropemacs-enable-autoimport t)

;;   ;; Adding hook to automatically open a rope project if there is one
;;   ;; in the current or in the upper level directory
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (cond ((file-exists-p ".ropeproject")
;;                      (rope-open-project default-directory))
;;                     ((file-exists-p "../.ropeproject")
;;                      (rope-open-project (concat default-directory "..")))
;;                     )))
;;   )



;(autoload 'python-mode "python-mode" "Python Mode." t)

;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

; (require 'python-mode)

;; PYMACS SETTINGS
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)
; (setq pymacs-python-command "~/.emacs.d/venv/bin/python")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
; (pymacs-load "ropemacs" "rope-")
; (setq ropemacs-enable-autoimport t)

;; (defun load-ropemacs ()
;;   "Load pymacs and ropemacs"
;;   (interactive)
;;   (require 'pymacs)
;;   (pymacs-load "ropemacs" "rope-")
;;   ;; Automatically save project python buffers before refactorings
;;   (setq ropemacs-confirm-saving 'nil)
;; )
;; (global-set-key "\C-xpl" 'load-ropemacs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;; 	   (setq value (cons (format "%s%s" prefix element) value))))))

;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")

;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))

;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))


;; ;;Ryan's python specific tab completion
;; ; Try the following:
;; ; 1) Do a yasnippet expansion
;; ; 2) Do a Rope code completion
;; ; 3) Do an indent
;; (defun ryan-python-tab ()
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))

;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))

;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))




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
  :ensure t
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






;; HOOKS
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (message "python mode hook")
;;             (auto-complete-mode t)
;;             (annotate-pdb)
;;             (lambda-mode)
;;             (flycheck-mode)
;;             (ac-ropemacs-initialize)
;;             ;;TODO: use virtualenv version
;;             ;;(setq pymacs-python-command py-python-command)
;;             (set-variable 'py-indent-offset 4)
;;             (set-variable 'py-smart-indentation nil)
;;             (set-variable 'indent-tabs-mode nil)
;;             (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))
;;             ))

;;; TODO: enable
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (require 'sphinx-doc)
;;             (sphinx-doc-mode t)
;;             ))


;;(load "python-mode-env.el")


(exec-path-from-shell-copy-env "PYTHONPATH")


(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))

    (with-temp-message (format "Switching projectile project to: %s" projectile-project-name))

    ;; (if (member project (pyenv-mode-versions))
    ;;     (pyenv-mode-set project)
    ;;   (pyenv-mode-unset))

    ))

(add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)


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


(use-package anaconda-mode
  :config (progn
            (add-hook 'python-mode-hook 'anaconda-mode)
            (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
            ))

(add-hook 'python-mode-hook 'python-mode-hook-callback)

(use-package company-anaconda
  :config
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))
  )


(use-package pyenv-mode
  :init
  (add-to-list 'exec-path "~/.pyenv/shims")
  (setenv "WORKON_HOME" "~/.pyenv/versions/")
  :config (progn
            (setq pyenv-show-active-python-in-modeline t)
            (pyenv-mode))
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

(use-package pip-requirements)


(use-package reformatter
  :config (progn
            ;; TODO make dynamic avaluation
            (setq pep8-command "autopep8"
                  isort-command "isort")

             (reformatter-define py-autopep8-format
               :program pep8-command
               :args '("--max-line-length=200" "-"))

             (reformatter-define py-autoimports-format
               :program isort-command
               :args '("--lines=100"
                       "-sp=/Users/Alexandr/vms/rambler/projects/crm/crm_backend2/"
                       "-"))
             )
  )


(provide 'python-mode-init)
;;; python-mode-init.el ends here
