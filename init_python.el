;; DEFIN VARIABLES
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;;IPYTHON MODE
(setq ipython-command "~./emacs.d/venv/bin/ipython")
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

(setq py-python-command-args '("-colors" "Linux"))
;;(setq py-python-command "/var/github/python2.6/bin/ipython")
;;(setq py-python-command "/var/github/python2.6/bin/python2.6")
;;(setq py-jython-command "/usr/bin/jython")
;;(defadvice py-execute-buffer (around python-keep-focus activate)
;; "return focus to python code buffer"
;; (save-excursion ad-do-it))


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
(setq pymacs-python-command "~/.emacs.d/venv/bin/python2.6")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

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


;; Auto Syntax Error Hightlight
(when (load "flymake" t)
  (custom-set-faces
   '(flymake-errline ((((class color)) (:background "red"))))
   '(flymake-warnline ((((class color)) (:background "orange")))))
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
					   'flymake-create-temp-inplace))
		   (local-file (file-relative-name
						temp-file
						(file-name-directory buffer-file-name))))
      ;;USE pyflakes command for check file
	  ;; can use epylint.py in emacs.d/epylint.py
	  (list "pyflakes" (list local-file)))
	)
  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.py\\'" flymake-pyflakes-init)))


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


;; HOOKS
(add-hook 'python-mode-hook
          (lambda ()
			(message "python mode hook")
			(auto-complete-mode t)
			(smart-operator-mode-on)
			(annotate-pdb)
			(lambda-mode)
            (ac-ropemacs-initialize)
			;;TODO: use virtualenv version
			;;(setq pymacs-python-command py-python-command)
			(set-variable 'py-indent-offset 4)
			(set-variable 'py-smart-indentation nil)
			(set-variable 'indent-tabs-mode nil)
			;; (setq 'ac-sources '(ac-source-ropemacs ))
			;; (setq yas/after-exit-snippet-hook 'indent-according-to-mode)
;			(set (make-local-variable 'ac-sources)
;				 (append ac-sources '(ac-source-rope)))
;			(set (make-local-variable 'ac-find-function) 'ac-python-find)
;			(set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;			(set (make-local-variable 'ac-auto-start) nil)
))


;;(add-hook 'python-mode-hook 'annotate-pdb)
;;(add-hook 'python-mode-hook 'lambda-mode)
(add-hook 'find-file-hook 'flymake-find-file-hook)

(provide 'init_python)
