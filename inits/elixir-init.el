;;; elixir-init.el ---



;;; Commentary:
;;

;;; Code:

(use-package elixir-mode
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))
            (add-hook 'elixir-mode-hook #'smartparens-mode)
           )
  )

(use-package alchemist)

(provide 'elixir-init)



;;; elixir-init.el ends here
