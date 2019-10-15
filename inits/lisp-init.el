;;; lisp-init.el ---

;;; Commentary:
;;

(defun conditionally-enable-lispy ()
  (when (eq this-command 'eval-expression)
    (lispy-mode 1)))

(use-package lispy
  :ensure t

  :config (progn
            (setq lispy-compat 1)
            (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
            (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
           )
  )


;; (require 'geiser-install)

;; (use-package geiser :ensure t)

(use-package geiser
  :ensure t
  :config
  (add-hook 'scheme-mode-hook 'geiser-mode))

;; (use-package geiser-install)


(use-package scheme48)



(defun hyperspec-lookup (&optional symbol-name)
  (interactive)
  (let ((browse-url-browser-function 'w3m-browse-url))
	(if symbol-name
		(common-lisp-hyperspec symbol-name)
	  (call-interactively 'common-lisp-hyperspec))))


(use-package hyperspec)


(provide 'lisp-init)

;;; lisp-init.el ends here
