;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"

;;(require 'ac-slime)


(use-package slime)


(use-package slime-scheme)

;;LISP-MODE
;;Common lisp compiler
;;(load (expand-file-name "~/.emacs.d/slime-helper.el"))
;;(setq slime-backend "~/.emacs.d/slime/swank-loader.lisp")
;;(setq inferior-lisp-program "/usr/bin/sbcl")


;;(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))


;;(setq inferior-lisp-program "docker run --rm -i emacsd /usr/bin/sbcl")

;; (setq slime-contribs '(slime-fancy))

;; (setq slime-startup-animation t)

(defmacro lisp-slime (lisp path &optional coding)
  (let ((funname (intern (format "%s-slime" lisp))))
	`(defun ,funname ()
	   (interactive)
	   (let ((inferior-lisp-program ,path)
			 (slime-net-coding-system (or ,coding 'utf-8-unix)))
		 (slime)))))

;;(lisp-slime sbcl "docker run --rm -i emacsd /usr/bin/sbcl")
;;(lisp-slime clisp "docker run --rm -i emacsd /usr/bin/clisp")

;;;(lisp-slime scheme "/usr/bin/scheme48")

;;(lisp-slime js (concat "node " (concat **emacs-dir** "swank-js/swank.js")))

(slime-setup '(slime-fancy
               slime-asdf
               slime-banner
               slime-repl
               slime-scratch
               ;;slime-highlight-edits
               slime-sbcl-exts
               slime-tramp
               slime-indentation
               slime-autodoc
               slime-company
               ;;						   slime-js))
))

;;(setq slime-contribs '(slime-fancy))


;; ;; ;; Set your lisp system and, optionally, some contribs
;;  ;; (setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
;;  ;; (setq slime-contribs '(slime-fancy))

;; (add-hook 'slime-mode-hook
;; 	  (lambda ()
;; 	    (message "Lisp mode hook")
;; 	    ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; 	    (set-up-slime-ac))
;; ;;     					 (setq ac-sources '(ac-source-words-in-buffer ac-source-symbols))))
;; 		;;					(setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer
;; 		;;														ac-source-files-in-current-dir
;; 		;;														ac-source-symbols ac-emacs-lisp-sources))
;; )

;; (add-hook 'lisp-mode-hook
;; 	  (lambda ()
;; 	    ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; 	    (setq lisp-indent-function 'common-lisp-indent-function)
;; 	    (message "lisp mode hook")
;; 	    (slime-mode t)
;;             (auto-complete-mode t)
;; 	    (define-key lisp-mode-map "\C-c \C-b" 'slime-eval-buffer)
;; 	    (font-lock-add-keywords nil
;; 				    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))
;; 	    (yas/minor-mode-on)))



;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'slime-repl-mode))


;; (message "slime init loaded")

(provide 'slime-init)
;;; slime-init.el ends
