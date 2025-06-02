;;; prog-mode-init.el ---

;;; Commentary:
;;

;;; Code:


(use-package lsp-mode
  :ensure t
  :init (progn
          (setq lsp-keymap-prefix "C-c l")
          )
  :hook ((rust-mode . lsp-deferred)
         (go-mode . lsp)
         (python-mode . lsp)
         (dart-mode . lsp)
         (elisp-mode . lsp)
         )
  :commands lsp
  :config (progn
            ;; (define-key lsp-mode-map (kbd "s-l") lsp-command-map)
            (setq lsp-log-io t)
            (setq lsp-prefer-capf t)
            (setq lsp-completion-provider :capf)
            (setq lsp-completion-enable t)
            (setq lsp-rust-server 'rust-analyzer)

            (setq lsp-headerline-breadcrumb-enable nil)
            (setq lsp-ui-doc-enable nil)

            (setq lsp-ui-sideline-enable nil)

            (setq lsp-rust-all-features t)

            ;; (setq lsp-treemacs-sync-mode nil)

            (require 'elsa)
            (require 'elsa-lsp)
            (elsa-lsp-register)

            ))



(use-package protobuf-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
            )
  )


(provide 'prog-mode-init)

;;; prog-mode-init.el ends here
