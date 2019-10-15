;;; bash-completion-init.el ---

;;; Commentary:
;;

;;; Code:

(add-to-list 'load-path (concat **emacs-ext-dir** "emacs-bash-completion"))

(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")

(use-package bash-completion
  :ensure t
  :config (progn
            (message "Package bash-completion config")
            (autoload 'bash-completion-dynamic-complete "bash-completion" "BASH completion hook")
            (add-hook 'shell-dynamic-complete-functions
                      'bash-completion-dynamic-complete)

            ;; HOOKS
            (add-hook 'shell-dynamic-complete-functions
                      'bash-completion-dynamic-complete)
            (add-hook 'shell-command-complete-functions
                      'bash-completion-dynamic-complete)
            )


  )



(message "bash-completion loaded")

(provide 'bash-completion-init)

;;; bash-completion-init.el ends here
