(add-to-list 'load-path (concat **emacs-ext-dir** "emacs-bash-completion"))

(autoload 'bash-completion-dynamic-complete
  "bash-completion"
  "BASH completion hook")



;; HOOKS
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)
(add-hook 'shell-command-complete-functions
  'bash-completion-dynamic-complete)

(message "bash-completion loaded")