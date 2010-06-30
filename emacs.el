
(add-to-list 'load-path "~/.emacs.d/") 
;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...
(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;(

;;;(load-file "/usr/share/emacs23/site-lisp/cedet-common/cedet.el")
;;;;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")
;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")

(require 'font-lock) (if (fboundp 'global-font-lock-mode) (global-font-lock-mode 1)) 
(require 'tramp)
(require 'color-theme)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'yasnippet)
(require 'python-mode)
(require 'css-mode)
;;(require 'js2-mode)
(require 'ipython)
(require 'ansi-color)
(require 'espresso)
(require 'django-html-mode)
(require 'smart-operator)
;;;(require 'ecb)
(require 'pymacs)
(require 'go-mode-load)
(require 'zencoding-mode)
(require 'rainbow-mode)
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
(color-theme-tango)

;;;(global-auto-complete-mode t)

(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8

;;initialize yasnippet
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")


(setq ipython-command "/var/github/python2.6/bin/ipython")

(defadvice py-execute-buffer (around python-keep-focus activate)
 "return focus to python code buffer"
 (save-excursion ad-do-it))

(defmacro lisp-slime (lisp path &optional coding)
 (let ((funname (intern (format "%s-slime" lisp))))
   `(defun ,funname ()
      (interactive)
      (let ((inferior-lisp-program ,path)
            (slime-net-coding-system (or ,coding 'utf-8-unix)))
        (slime)))))

(lisp-slime sbcl "/usr/bin/sbcl")
(lisp-slime clisp "/usr/bin/clisp")

(require 'hyperspec)

(defun hyperspec-lookup (&optional symbol-name)
 (interactive)
 (let ((browse-url-browser-function 'w3m-browse-url))
   (if symbol-name
       (common-lisp-hyperspec symbol-name)
     (call-interactively 'common-lisp-hyperspec))))

(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . rainbow-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . rainbow-mode))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
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
						   (setq css-indent-offset 2)
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
			(set-variable 'py-indent-offset 4)
			(set-variable 'indent-tabs-mode T)
			(define-key py-mode-map (kbd "RET") 'newline-and-indent)
			(smart-operator-mode-on)
			(setq 'ac-sources '(ac-source-ropemacs ))
))

(add-hook 'espresso-mode-hook (lambda ()
                                (setq espresso-indent-level 2)))

(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

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

(defun autocompile ()
  "Compile itself if this is config file"
  (interactive)
  (if (or
       (string-match ".emacs.d/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   (string-match ".emacs.d/tramp/[a-zA-z_\+\-]*.el$" (buffer-file-name))
	   )
      (byte-compile-file (buffer-file-name))))

;;(add-hook 'after-save-hook 'autocompile)

(provide 'emacs)
