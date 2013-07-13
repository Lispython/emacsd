(defconst **emacs-dir** "~/.emacs.d/"
  "Top level emacs directory")

(defconst **emacs-ext-dir** (concat **emacs-dir** "ext/")
  "Directory that store third party modes/etc/")

(add-to-list 'load-path **emacs-dir**)
(setq emacs-d-dir "~/.emacs.d/pylookup/")
;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...

;;(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;;(set-face-font 'default "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")
(set-face-font 'default "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;;(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;

;; Font family
(set-frame-font "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")


;;(load-file "/usr/share/emacs23/site-lisp/cedet-common/cedet.el")
;;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")

;;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")
(add-to-list 'load-path "~/.emacs.d/slime/")
(add-to-list 'load-path "~/.emacs.d/slime/contrib/")
(add-to-list 'load-path "~/.emacs.d/js-swank/")
(add-to-list 'load-path "~/.emacs.d/jshint-mode/")


;;(add-to-list 'load-path "~/.emacs.d/virtualenv/")
;;add jabber mode
(add-to-list 'load-path "~/.emacs.d/emacs-jabber/")

;;(add-to-list 'load-path "~/.emacs.d/python-mode-6.0/")

;;AUTO COMPLETE
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/auto-complete-modes/")
(add-to-list 'load-path "~/.emacs.d/auto-complete-modes/ac-slime/")
(add-to-list 'load-path "~/.emacs.d/mo-git-blame/")
(add-to-list 'load-path "~/.emacs.d/ext/yasnippet")
(add-to-list 'load-path "~/.emacs.d/ext")

;;(add-to-list 'load-path "~/.emacs.d/auto-complete/ext/")

(add-to-list 'load-path "~/.emacs.d/magit/")
(add-to-list 'load-path "~/.emacs.d/inits/")

(setq pylookup-dir "~/.emacs.d/pylookup/")
(add-to-list 'load-path pylookup-dir)


(load-file "~/.emacs.d/nxml-mode/rng-auto.el")

;;GLOBAL REQUIREMENTS
(require 'font-lock) (if (fboundp 'global-font-lock-mode)
			 (global-font-lock-mode 1))

(mapc 'require '(tramp
		 color-theme
		 auto-complete-config
		 ac-slime
		 yasnippet
		 anything
		 ansi-color
		 smart-operator))
;; (require 'tramp)
;; (require 'color-theme)
;; ;;(require 'auto-complete)
;; (require 'auto-complete-config)
;; (require 'ac-slime)
;; (require 'yasnippet)
;; (require 'anything)
;; (require 'ansi-color)
;; (require 'smart-operator)

;;MODES
(require 'go-mode-load)
(require 'css-mode)
(require 'js2-mode)
(require 'espresso)
(require 'django-html-mode)
(require 'regex-tool)
(require 'slime)
(require 'magit)
;(require 'jabber-autoloads)
;;;(require 'python-mode)
;;;(require 'ecb)
;;;(require 'zencoding-mode)
(require 'rainbow-mode)
(require 'http-twiddle)
(require 'fill-column-indicator)

;;;PYTHON REQUIREMENTS
(require 'lambda-mode)
(require 'python-pep8)
(require 'python-pylint)
(require 'hyperspec)
(require 'anything-ipython)
(require 'pymacs)
(require 'hide-region)
(require 'scheme48)
(require 'slime-scheme)
(require 'go-autocomplete)
;;(require 'flymake-jshint)


;;SET VARIABLES OF EMACS
(scroll-bar-mode nil) ;hide scrroll bar
;;(menu-bar-mode nil) ;this too
(tool-bar-mode nil) ;hide tool bar too
;; Turn on column number mode
(column-number-mode t) ;; but this one is good
;;(ido-mode t)
(setq flymake-start-syntax-check-on-find-file nil)

(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t) ;;;do't show splash screen
;;(setq default-tab-width 4)
(setq tab-with 4)
(desktop-save-mode t)
(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8

;;; Current line hightlight
(global-hl-line-mode t)
;(set-face-background 'hl-line "#330")  ;; Emacs 22 Only

; Makes clipboard work
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(delete-selection-mode t) ;; Delete selected by Ctrl-D
(transient-mark-mode t) ;;hightlight by C-Space
;; enable horizontal scrolling
;;(hscroll-global-mode t)

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

;;FILL

(setq fci-rule-width 1)
;;(setq fci-rule-color "darkblue")
(setq fci-rule-column 80)

;; (define-globalized-minor-mode global-fci-mode fci-mode
;;   (lambda () (fci-mode 1)))
;; (global-fci-mode 1)

;; YASNIPPET
(yas/initialize)

(setq yas/snippet-dirs '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets"))

(setq yas/root-directory '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets" ))

;; Map `yas/load-directory' to every element
(mapc 'yas/load-directory yas/root-directory)
(yas/global-mode 1)

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
;;(load (expand-file-name "~/.emacs.d/slime-helper.el"))
(setq slime-backend "~/.emacs.d/slime/swank-loader.lisp")
(setq inferior-lisp-program "/usr/bin/sbcl")

(setq slime-startup-animation t)

(defmacro lisp-slime (lisp path &optional coding)
  (let ((funname (intern (format "%s-slime" lisp))))
	`(defun ,funname ()
	   (interactive)
	   (let ((inferior-lisp-program ,path)
			 (slime-net-coding-system (or ,coding 'utf-8-unix)))
		 (slime)))))

(lisp-slime sbcl "/usr/bin/sbcl")
(lisp-slime clisp "/usr/bin/clisp")
;;;(lisp-slime scheme "/usr/bin/scheme48")

(lisp-slime js "node /home/alex/.emacs.d/swank-js/swank.js")

(slime-setup '(slime-fancy slime-asdf slime-banner slime-repl
			   slime-scratch
			   ;;slime-highlight-edits
			   slime-sbcl-exts slime-tramp slime-indentation
			   slime-autodoc
			   ;;						   slime-js))
))


;; AUTO COMPLETE CONFIGS
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict/")
(ac-config-default)
(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.8)
(setq ac-quick-help-delay 0.3)
(setq ac-dwim t)
(setq ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))

(eval-after-load "auto-complete"
     '(add-to-list 'ac-modes 'slime-repl-mode))

(defun smart-tab ()
  (interactive)
  (if (eql (ac-start) nil)
      (indent-for-tab-command)))

;; KEYMAPS
(define-key ac-mode-map (kbd "C-c h") 'ac-last-quick-help)
(define-key ac-mode-map (kbd "C-c H") 'ac-last-help)
;;(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(define-key ac-mode-map (kbd "TAB") 'smart-tab)
(define-key py-mode-map "\t" 'smart-tab)
(global-set-key (kbd "C-c h r") 'hide-region-hide)
(global-set-key (kbd "C-c h u") 'hide-region-unhide)

;;auto complete
;;(define-key ac-complete-mode-map "\t" 'auto-complete)
;;(define-key ac-mode-map "\r" nil)


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

(load "outline-mode-init.el")
(load "ibuffer-mode-init.el")
(load "python-mode-init.el")
(load "org-mode-init.el")
(load "js-mode-init.el")
(load "css-mode-init.el")
(load "sudo-save.el")
(load "org-readme.el")
(load "bash-completion-init.el")
(load "tramp-mode-init.el")
(load "yaml-mode-init.el")

;;(load "go-mode-init")
;;(load "recompiler")

(require 'ipython)


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



(add-hook 'slime-mode-hook
	  (lambda ()
	    (message "Lisp mode hook")
	    ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
	    (set-up-slime-ac))
;;     					 (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
		;;					(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer
		;;														ac-source-files-in-current-dir
		;;														ac-source-symbols ac-emacs-lisp-sources))
)

(add-hook 'lisp-mode-hook
	  (lambda ()
	    ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
	    (setq lisp-indent-function 'common-lisp-indent-function)
	    (message "css mode hook")
	    (slime-mode t)
	    (define-key lisp-mode-map "\C-c \C-b" 'slime-eval-buffer)
	    (font-lock-add-keywords nil
				    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))
	    (yas/minor-mode-on)))

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)


(add-hook 'css-mode-hook (lambda ()
						   (message "css mode hook")
						   (rainbow-mode t)
						   ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
						   ;;(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
;;						   (setq ac-sources '(ac-source-css-keywords))
))


(add-hook 'emacs-lisp-mode-hook (lambda ()
								  (message "emacs lisp mode hook")
								  ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
								  ;; (setq ac-sources '(ac-source-words-in-buffer
								  ;; 					 ac-source-symbols))
								   ;; (setq ac-sources '(ac-source-abbrev
								   ;; 					 ac-source-words-in-buffer
								   ;; 					 ac-source-files-in-current-dir
								   ;; 					 ac-source-symbols ac-emacs-lisp-sources))
								  ))



(add-hook 'espresso-mode-hook (lambda ()
				;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
                                (setq espresso-indent-level 2)))

;;;(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;(add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

(add-hook 'ipython-shell-hook (lambda ()
								  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook 'autocompile)


(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(provide 'emacs)
