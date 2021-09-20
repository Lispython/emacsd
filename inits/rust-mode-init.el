;;; rust-mode-init.el ---


;;; Commentary:
;;

;;; Code:


(use-package rust-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

            (use-package flycheck-rust
              :ensure t

              :config (progn
                        (with-eval-after-load 'rust-mode
                          (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
                          ;;(add-hook 'flycheck-mode-hook #'flycheck-inline-mode)

                          ))
              )


            ;; (lsp-rust-analyzer-cargo-watch-command "clippy")


            (add-hook 'rust-mode-hook 'cargo-minor-mode)
            (add-hook 'rust-mode-hook #'smartparens-mode)

            (add-hook 'rust-mode-hook
                      (lambda ()
                        (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)
                        ))

            ;;(defalias 'racer--call 'racer--call-override )

            ;; (setq company-tooltip-align-annotations t)
            )
  )

;; (use-package lsp-rust
;;   :after lsp-mode
;;   :demand t
;;   :custom
;;   (lsp-rust-clippy-preference "on")
;;   (lsp-rust-cfg-test t)
;;   (lsp-rust-build-on-save t))



(provide 'rust-mode-init)

;;; rust-mode-init.el ends here
