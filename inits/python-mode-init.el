;; DEFIN VARIABLES
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;IPYTHON MODE
(setq ipython-command "~/.emacs.d/venv/bin/ipython")
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

(setq py-shell-name "~/.emacs.d/venv/bin/ipython")

(setq py-block-comment-prefix "#")

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



(autoload 'python-mode "python-mode" "Python Mode." t)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'python-mode)

;; PYMACS SETTINGS
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(setq pymacs-python-command "~/.emacs.d/venv/bin/python")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

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
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
	   (setq value (cons (format "%s%s" prefix element) value))))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))


;;Ryan's python specific tab completion
; Try the following:
; 1) Do a yasnippet expansion
; 2) Do a Rope code completion
; 3) Do an indent
(defun ryan-python-tab ()
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))

(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))

(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))


;;PYLOOKUP
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

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

(add-hook 'python-mode-hook
          (lambda ()
            (require 'sphinx-doc)
            (sphinx-doc-mode t)
            ))
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

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
