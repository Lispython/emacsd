(setq debug-on-error t)

(defconst **emacs-dir** "~/.emacs.d/"
  "Top level emacs directory")

(defconst **emacs-ext-dir** (concat **emacs-dir** "ext/")
  "Directory that store third party modes/etc/")

(defconst **themes-dir** (concat **emacs-dir** "themes/")
  "Directory than store editor themes")

(defconst **docker-run** "docker run --rm -i emacsd")

(defconst **docker-run-base** "/usr/local/bin/docker run -i --rm")

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line



(add-to-list 'load-path **emacs-dir**)

(defun with-emacs.d (&rest args)
  (mapconcat 'identity (append (list (file-truename **emacs-dir**)) args) "")
  )

;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...

;;(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;;(set-face-font 'default "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")
;;(set-face-font 'default "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;;(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;

;; Font family
;;(set-frame-font "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")


;;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")
;(add-to-list 'load-path "~/.emacs.d/slime/")
;(add-to-list 'load-path "~/.emacs.d/slime/contrib/")
(add-to-list 'load-path "~/.emacs.d/js-swank/")
(add-to-list 'load-path "~/.emacs.d/jshint-mode/")


;;(add-to-list 'load-path "~/.emacs.d/virtualenv/")
;;add jabber mode
(add-to-list 'load-path "~/.emacs.d/emacs-jabber/")

;;(add-to-list 'load-path "~/.emacs.d/ext/python-mode/")

(add-to-list 'load-path (concat **emacs-ext-dir** "go-mode"))

;;AUTO COMPLETE
(add-to-list 'load-path "~/.emacs.d/ext/auto-complete/lib/popup")
(add-to-list 'load-path "~/.emacs.d/ext/auto-complete/lib/fuzzy")
(add-to-list 'load-path "~/.emacs.d/ext/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/auto-complete-modes/")
;(add-to-list 'load-path "~/.emacs.d/auto-complete-modes/ac-slime/")
(add-to-list 'load-path "~/.emacs.d/mo-git-blame/")
(add-to-list 'load-path "~/.emacs.d/ext")
(add-to-list 'load-path "~/.emacs.d/ext/restclient")
(add-to-list 'load-path "~/.emacs.d/ext/editorconfig/")
(add-to-list 'load-path "~/.emacs.d/ext/auto-highlight-symbol/")

;;(add-to-list 'load-path "~/.emacs.d/ext/auto-complete/ext/")

(add-to-list 'load-path "~/.emacs.d/magit/")
(add-to-list 'load-path "~/.emacs.d/inits/")


(load-file "~/.emacs.d/nxml-mode/rng-auto.el")


;;GLOBAL REQUIREMENTS
(require 'font-lock)

(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))


(require 'ansi-color)
(require 'anything)
(require 'color-theme)
(require 'ac-emoji)
(require 'cc-mode)

;;(add-to-list 'custom-theme-load-path **themes-dir**)

;; (mapc 'require '(tramp
;; 		 auto-complete-config
;; 		 ac-slime
;; 		 ansi-color
;; 		 ))

(require 'tramp)
(require 'auto-complete-config)
(require 'ansi-color)


;;MODES
(require 'go-mode-load)
(require 'docker)
(require 'css-mode)
(require 'js2-mode)
(require 'espresso)
(require 'django-html-mode)
(require 'regex-tool)
(require 'slime)
(require 'restclient)
;;(require 'magit)
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
;;(require 'pymacs)
(require 'hide-region)
(require 'scheme48)
(require 'slime-scheme)
;;(require 'go-autocomplete)
;;(require 'flymake-jshint)

(require 'powerline)

(require 'multiple-cursors)


;; (require 'pyenv-mode)
;; (pyenv-mode)

;; (require 'pyenv-mode-auto)


;;(require 'flycheck)
;;(global-flycheck-mode)

;;SET VARIABLES OF EMACS
(scroll-bar-mode nil) ;hide scrroll bar
(scroll-bar-mode -1)
(menu-bar-mode nil) ;this too
(tool-bar-mode nil) ;hide tool bar too
(tool-bar-mode -1)
;; Turn on column number mode
(column-number-mode t) ;; but this one is good
;;(ido-mode t)
;;(setq flymake-start-syntax-check-on-find-file nil)

;; Don't disable
(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t) ;;;do't show splash screen
;;(setq default-tab-width 4)
(setq tab-with 4)
(setq-default indent-tabs-mode nil)
(desktop-save-mode t)
(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8

;;; Current line hightlight
(global-hl-line-mode t)
;(set-face-background 'hl-line "#330")  ;; Emacs 22 Only

; Makes clipboard work
(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;;for emacs 2.4
(setq interprogram-paste-function 'x-selection-value)
(delete-selection-mode t) ;; Delete selected by Ctrl-D
(transient-mark-mode t) ;;hightlight by C-Space
;; enable horizontal scrolling
;;(hscroll-global-mode t)

;;THEMES
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-solarized t)
;;(color-theme-solarized t)
;;(load-theme 'solarized t)


;;;(color-theme-tango)

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome")

(setq browse-url-browser-function 'browse-url-default-windows-browser)
(setq browse-url-browser-function 'browse-url-default-macosx-browser)


(powerline-default-theme)


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

;; MODES AUTO DETECT
;;(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;;(add-to-list 'a>uto-mode-alist '("\\.json$" . espresso-mode))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))





;; AUTO COMPLETE CONFIGS
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict/")
(ac-config-default)
(setq ac-auto-start 1)
(setq ac-auto-show-menu 0.8)
(setq ac-quick-help-delay 0.3)
(setq ac-dwim t)
(setq ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))


(defun smart-tab ()
  (interactive)
  (if (eql (ac-start) nil)
      (indent-for-tab-command)))

;; KEYMAPS
(define-key ac-mode-map (kbd "C-c h") 'ac-last-quick-help)
(define-key ac-mode-map (kbd "C-c H") 'ac-last-help)
;;(define-key ac-mode-map (kbd "TAB") 'auto-complete)
(define-key ac-mode-map (kbd "TAB") 'smart-tab)

(global-set-key (kbd "C-c h r") 'hide-region-hide)
(global-set-key (kbd "C-c h u") 'hide-region-unhide)

;;auto complete
;;(define-key ac-complete-mode-map "\t" 'auto-complete)
;;(define-key ac-mode-map "\r" nil)


(when (require 'anything-show-completion nil t)
  (use-anything-show-completion
   'anything-ipython-complete
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

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(load "env-init.el")
(load "virtualenv-init.el")
(load "outline-mode-init.el")
(load "ibuffer-mode-init.el")
;;(load "python-mode-init.el")
(load "python-mode-dockerized-init.el")
(load "org-mode-init.el")
(load "js-mode-init.el")
(load "css-mode-init.el")
(load "sudo-save.el")
(load "org-readme.el")
(load "bash-completion-init.el")
(load "tramp-mode-init.el")
(load "yaml-mode-init.el")
(load "sgml-mode-init.el")
(load "autopep8-init.el")
(load "flycheck-init.el")
(load "crontab-init.el")
(load "ac-emoji.el")
(load "markdown-init.el")
(load "slime-init.el")
(load "highlight-symbol-init.el")
(load "clang-init.el")
(load "debug-init.el")


;;; Python configuration
(load "pylookup-init.el")


(load "yasnippet-init.el")


;;(load "go-mode-init")
;;(load "recompiler")



(defun autocompile ()
  "Compile itself if this is config file"
  (interactive)
  (if (or
       (string-match ".emacs.d/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/tramp/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/themes/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   )
      (byte-compile-file (buffer-file-name))))

;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;;; HOOKS FOR MODES



(add-hook 'css-mode-hook
          (lambda ()
            (message "css mode hook")
            (rainbow-mode t)
            ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
            ;;(setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
            ;;						   (setq ac-sources '(ac-source-css-keywords))
))


(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (message "emacs lisp mode hook")
            ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
								  ;; (setq ac-sources '(ac-source-words-in-buffer
								  ;; 					 ac-source-symbols))
								   ;; (setq ac-sources '(ac-source-abbrev
								   ;; 					 ac-source-words-in-buffer
								   ;; 					 ac-source-files-in-current-dir
								   ;; 					 ac-source-symbols ac-emacs-lisp-sources))
								  ))



(add-hook 'espresso-mode-hook
          (lambda ()
            ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
            (setq espresso-indent-level 2)))

;;;(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;;(add-hook 'python-mode-hook #'(lambda ()
;;                                 (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))


(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook 'autocompile)


(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(provide 'emacs)
