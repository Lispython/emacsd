;;; lisp-init.el ---

;;; Commentary:
;;

(defun conditionally-enable-lispy ()
  (when (eq this-command 'eval-expression)
    (lispy-mode 1)))

(use-package lispy

  :config (progn
            (setq lispy-compat 1)
            (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
            (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
           )
  )


(use-package geiser-install)

(provide 'lisp-init)

;;; lisp-init.el ends here
