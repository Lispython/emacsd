;;; elixir-init.el ---



;;; Commentary:
;;

;;; Code:

(use-package elixir-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.elixir2\\'" . elixir-mode))
            (add-hook 'elixir-mode-hook #'smartparens-mode)
            )
  )

(use-package alchemist
  :ensure t
  )

(provide 'elixir-init)



;;; elixir-init.el ends here
