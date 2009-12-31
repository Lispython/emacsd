(add-to-list 'load-path "~/.emacs.d/") 
(load-file "/usr/share/emacs23/site-lisp/cedet-common/cedet.el")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/ecb")

(require 'font-lock) (if (fboundp 'global-font-lock-mode) (global-font-lock-mode 1)) 
(require 'color-theme)
(require 'auto-complete)
(require 'auto-complete-config)
(require 'yasnippet)
(require 'ipython)
(require 'espresso)
(require 'django-html-mode)
(require 'ecb)

;;(scroll-bar-mode nil) ;;hide scrroll bar
;;(menu-bar-mode nil)        ;; this too
(column-number-mode t)    ;; but this one is good
;;(ido-mode t)

;; Turn on column number mode
(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p) 

(setq default-tab-width 4) 

(global-auto-complete-mode t)
;;;(global-font-lock-mode 1)
;;;(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-tty-dark)

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

(set-default-font "Monospace-9") ;;default font

(when (require 'auto-complete nil t)
  (require 'auto-complete-yasnippet)
  (require 'auto-complete-python)
  (require 'auto-complete-css) 
  (require 'auto-complete-cpp)  
  (require 'auto-complete-emacs-lisp)  
  (require 'auto-complete-semantic)  
  (require 'auto-complete-gtags)

  (global-auto-complete-mode t)
  (setq ac-auto-start 3)
  (setq ac-dwim t)
  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-symbols))

;;;(load-library "init_python")
(provide 'emacs)