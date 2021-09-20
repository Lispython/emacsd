;;; prog-mode-init.el ---

;;; Commentary:
;;

;;; Code:

(use-package lsp-mode
  :ensure t
  :init (progn
          (setq lsp-keymap-prefix "C-c l")
          )
  :hook ((rust-mode . lsp)
         (go-mode . lsp)
         ;;(python-mode . lsp)
         )
  :commands lsp
  :config (progn
            (setq lsp-log-io t)
            (setq lsp-prefer-capf t)
            (setq lsp-completion-provider :capf)
            (setq lsp-completion-enable t)
            (setq lsp-rust-server 'rust-analyzer)

            (setq lsp-headerline-breadcrumb-mode nil)

            ))

;; (use-package lsp-ui
;;   :ensure t
;;   :hook (erlang-mode . 'flycheck-mode)
;;   :config (progn
;;             (require 'lsp-imenu)
;;             (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)

;;             )
;;   :commands lsp-ui-mode)


;(use-package company-box
;  :ensure t
;  :hook (company-mode . company-box-mode))

;; (use-package lsp-ivy
;;   :after ivy
;;   )


;; (use-package lsp-origami
;;   :after (lsp-mode origami-mode)
;;   )


;; (use-package eglot
;;   :ensure t
;;   )

(provide 'prog-mode-init)

;;; prog-mode-init.el ends here
