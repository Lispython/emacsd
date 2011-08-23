(add-to-list 'load-path "~/.emacs.d/")
(setq emacs-d-dir "~/.emacs.d/pylookup/")
;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...
(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;;(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;(

;;(load-file "/usr/share/emacs23/site-lisp/cedet-common/cedet.el")
;;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")

;;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")
(add-to-list 'load-path "~/.emacs.d/slime/")
;;(add-to-list 'load-path "~/.emacs.d/virtualenv/")
;;add jabber mode
;;(add-to-list 'load-path "~/.emacs.d/emacs-jabber/")
;;(add-to-list 'load-path "~/.emacs.d/python-mode-6.0/")

;;AUTO COMPLETE
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
;;(add-to-list 'load-path "~/.emacs.d/auto-complete/ext/")

(add-to-list 'load-path "~/.emacs.d/magit/")

(setq pylookup-dir "~/.emacs.d/pylookup/")
(add-to-list 'load-path pylookup-dir)

(load-file "~/.emacs.d/nxml-mode/rng-auto.el")

;;GLOBAL REQUIREMENTS
(require 'font-lock) (if (fboundp 'global-font-lock-mode) (global-font-lock-mode 1))
(require 'tramp)
(require 'color-theme)
;;(require 'auto-complete)
(require 'auto-complete-config)
(require 'yasnippet)
(require 'anything)
(require 'ansi-color)
(require 'smart-operator)

;;MODES
(require 'go-mode-load)
(require 'css-mode)
(require 'js2-mode)
(require 'espresso)
(require 'django-html-mode)
(require 'regex-tool)
(require 'slime)
(require 'magit)
;;;(require 'jabber-autoloads)
;;;(require 'python-mode)
;;;(require 'ecb)
;;;(require 'zencoding-mode)
(require 'rainbow-mode)
(require 'http-twiddle)

;;;PYTHON REQUIREMENTS
(require 'lambda-mode)
(require 'python-pep8)
(require 'python-pylint)
(require 'hyperspec)
(require 'anything-ipython)
(require 'pymacs)



;;SET VARIABLES OF EMACS
(setq tramp-default-method "ssh")
(scroll-bar-mode nil) ;hide scrroll bar
;;(menu-bar-mode nil) ;this too
(tool-bar-mode nil) ;hide tool bar too
;; Turn on column number mode
(column-number-mode t) ;; but this one is good
;;(ido-mode t)

(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t) ;;;do't show splash screen
(setq default-tab-width 4)
(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8

; Makes clipboard work
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;THEMES
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-solarized t)
;;;(color-theme-tango)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;;MODES VARIABLES
(global-auto-complete-mode t)
;;;(global-font-lock-mode 1)


;; YASNIPPET
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; MODES AUTO DETECT
;;add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;;(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))


;;LISP-MODE
;;Common lisp compiler
(defmacro lisp-slime (lisp path &optional coding)
  (let ((funname (intern (format "%s-slime" lisp))))
	`(defun ,funname ()
	   (interactive)
	   (let ((inferior-lisp-program ,path)
			 (slime-net-coding-system (or ,coding 'utf-8-unix)))
		 (slime)))))

(lisp-slime sbcl "/usr/bin/sbcl")
(lisp-slime clisp "/usr/bin/clisp")

;;;SWANK-JS connection to slime
;;(slime-setup '(slime-repl slime-js))
;;(global-set-key [f5] 'slime-js-reload)
;;(add-hook 'js2-mode-hook
;;		  (lambda ()
;;			(slime-js-minor-mode 1)))



;; AUTO COMPLETE CONFIGS
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict/")
(setq ac-auto-start 3)
(setq ac-auto-show-menu 0.8)
(setq ac-quick-help-delay 0.5)
(setq ac-dwim t)
(ac-config-default)

;; KEYMAPS
(define-key ac-mode-map (kbd "C-c h") 'ac-last-quick-help)
(define-key ac-mode-map (kbd "C-c H") 'ac-last-help)
(define-key ac-mode-map (kbd "TAB") 'auto-complete)


;; DEPRICATED FOR AUTO COMPLETE 1.4
;; (when (require 'auto-complete nil t)
;; ;;  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

;;   (setq ac-auto-start 2)
;;   (setq ac-dwim t)
;;   ;;(require 'auto-complete-yasnippet)
;;   (require 'auto-complete-python)
;;   ;;(require 'auto-complete-css)
;;   (require 'auto-complete-emacs-lisp)
;;   ;;(require 'auto-complete-semantic)
;;   ;;(require 'auto-complete-gtags)
;;   (set-default 'ac-sources '(ac-source-words-in-buffer
;; 							 ac-source-symbols)))


(when (require 'anything-show-completion nil t)
  (use-anything-show-completion 'anything-ipython-complete
								'(length initial-pattern)))


(defun hyperspec-lookup (&optional symbol-name)
  (interactive)
  (let ((browse-url-browser-function 'w3m-browse-url))
	(if symbol-name
		(common-lisp-hyperspec symbol-name)
	  (call-interactively 'common-lisp-hyperspec))))


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
;(load-library "recompiler")

(require 'ipython)

(setq jabber-account-list
    (quote (
           ("s2nek@jabber.ru" (:password . "628mWct=") (:network-server . "jabber.ru") (:connection-type . starttls))
           )
    )
)


(defun autocompile ()
  "Compile itself if this is config file"
  (interactive)
  (if (or
       (string-match ".emacs.d/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/tramp/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/themes/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   )
      (byte-compile-file (buffer-file-name))))


;;; HOOKS FOR MODES

;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"
(add-hook 'lisp-mode-hook (lambda ()
							(message "css mode hook")
							(slime-mode t)))

(add-hook 'css-mode-hook (lambda ()
						   (message "css mode hook")
						   (rainbow-mode t)
						   ;;(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
						   (setq ac-sources '(ac-source-css-keywords))))

(add-hook 'lisp-mode-hook (lambda ()
							(message "lisp mode hook")
;;							 (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
							(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer
																ac-source-files-in-current-dir
																ac-source-symbols ac-emacs-lisp-sources))
							))

(add-hook 'emacs-lisp-mode-hook (lambda ()
								  (message "emacs lisp mode hook")
								  ;; (setq ac-sources '(ac-source-words-in-buffer
								  ;; 					 ac-source-symbols))
								  ;; (setq ac-sources '(ac-source-abbrev
								  ;; 					 ac-source-words-in-buffer
								  ;; 					 ac-source-files-in-current-dir
								  ;; 					 ac-source-symbols ac-emacs-lisp-aources))
								  ))



(add-hook 'espresso-mode-hook (lambda ()
                                (setq espresso-indent-level 2)))

;;;(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;(add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

(add-hook 'ipython-shell-hook #'(lambda ()
								  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'after-save-hook 'autocompile)

(provide 'emacs)