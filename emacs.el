(add-to-list 'load-path "~/.emacs.d/")
;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...
(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;(

;;;(load-file "/usr/share/emacs23/site-lisp/cedet-common/cedet.el")
;;;;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")
;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")
(add-to-list 'load-path "~/.emacs.d/slime/")
;;add jabber mode
(add-to-list 'load-path "~/.emacs.d/emacs-jabber/")
;;(add-to-list 'load-path "~/.emacs.d/python-mode-6.0/")

(setq pylookup-dir "~/.emacs.d/pylookup/")

(add-to-list 'load-path pylookup-dir)


(require 'font-lock) (if (fboundp 'global-font-lock-mode) (global-font-lock-mode 1))
(require 'tramp)
(require 'color-theme)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'yasnippet)
;;;(require 'python-mode)
(require 'css-mode)
(require 'js2-mode)

(require 'ansi-color)
(require 'espresso)
(require 'django-html-mode)
(require 'smart-operator)
;;(require 'ecb)
(require 'pymacs)
(require 'go-mode-load)
;;(require 'zencoding-mode)
(require 'rainbow-mode)
(require 'http-twiddle)
(require 'regex-tool)
(require 'slime)
(require 'lambda-mode)
(require 'python-pep8)
(require 'python-pylint)
(require 'hyperspec)
(require 'jabber-autoloads)



(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"


(setq tramp-default-method "ssh")

(scroll-bar-mode nil) ;;hide scrroll bar
;;(menu-bar-mode nil) ;this too
(tool-bar-mode nil) ;;this too
(column-number-mode t)    ;; but this one is good
;;(ido-mode t)

;; Turn on column number mode
(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t) ;;;do't show splash screen
(setq default-tab-width 4)

; Makes clipboard work
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(global-auto-complete-mode t)
;;;(global-font-lock-mode 1)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-solarized t)
;;;(color-theme-tango)
;;;(global-auto-complete-mode t)

(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8

;;initialize yasnippet
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")


(setq ipython-command "/var/github/python2.6/bin/ipython")
;;(setq py-python-command-args '("-colors" "Linux"))
;;(setq py-python-command "/var/github/python2.6/bin/ipython")
;;(defadvice py-execute-buffer (around python-keep-focus activate)
;; "return focus to python code buffer"
;; (save-excursion ad-do-it))




(defmacro lisp-slime (lisp path &optional coding)
 (let ((funname (intern (format "%s-slime" lisp))))
   `(defun ,funname ()
      (interactive)
      (let ((inferior-lisp-program ,path)
            (slime-net-coding-system (or ,coding 'utf-8-unix)))
        (slime)))))

(lisp-slime sbcl "/usr/bin/sbcl")
(lisp-slime clisp "/usr/bin/clisp")


(slime-setup '(slime-repl slime-js))

(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
		  (lambda ()
			(slime-js-minor-mode 1)))



(defun hyperspec-lookup (&optional symbol-name)
 (interactive)
 (let ((browse-url-browser-function 'w3m-browse-url))
   (if symbol-name
       (common-lisp-hyperspec symbol-name)
     (call-interactively 'common-lisp-hyperspec))))

;;(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;;(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;;(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))


;;(setq py-python-command "/var/github/python2.6/bin/python2.6")
;;(setq py-jython-command "/usr/bin/jython")

(when (require 'auto-complete nil t)
  ;;(require 'auto-complete-yasnippet)
  (require 'auto-complete-python)
  ;;(require 'auto-complete-css)
  ;;(require 'auto-complete-emacs-lisp)
  ;;(require 'auto-complete-semantic)
  ;;(require 'auto-complete-gtags)
  (setq ac-auto-start 2)
  (setq ac-dwim t)
  (set-default 'ac-sources '(ac-source-words-in-buffer ac-source-symbols)))

(add-hook 'css-mode-hook (lambda ()
		   (message "css mode hook")
		   (rainbow-mode t)
		   ;;(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
(setq ac-sources '(ac-source-css-keywords))))

(add-hook 'lisp-mode-hook (lambda ()
							(message "lisp mode hook")
;;							 (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
							(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols ac-emacs-lisp-sources))
							))

(add-hook 'emacs-lisp-mode-hook (lambda ()
							(message "emacs lisp mode hook")
							;; (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
;;							(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols ac-emacs-lisp-aources))
							))


(add-hook 'python-mode-hook
		  (lambda ()
			(message "python mode hook")
;;			(smart-operator-mode-on)
;;			(setq 'ac-sources '(ac-source-ropemacs ))
))
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(add-hook 'python-mode-hook 'lambda-mode)
(add-hook 'espresso-mode-hook (lambda ()
                                (setq espresso-indent-level 2)))

;;;(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)



(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(defun python-add-breakpoint ()
  (interactive)
  (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))

;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
(add-hook 'python-mode-hook 'annotate-pdb)


;;; Comment and uncomment function
(defun comment-or-uncomment-this (&optional lines)
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
		(comment-or-uncomment-region (point) (mark)))
	(comment-or-uncomment-region
	 (line-beginning-position)
	 (line-end-position lines))))

(load-library "init_python")

(require 'ipython)

(setq jabber-account-list
    (quote (
           ("s2nek@jabber.ru" (:password . "628mWct=") (:network-server . "jabber.ru") (:connection-type . starttls))
           )
    )
)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(defun autocompile ()
  "Compile itself if this is config file"
  (interactive)
  (if (or
       (string-match ".emacs.d/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/tramp/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/themes/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   )
      (byte-compile-file (buffer-file-name))))

(add-hook 'after-save-hook 'autocompile)

(provide 'emacs)