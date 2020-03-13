;;; prog-mode-init.el ---

;;; Commentary:
;;

;;; Code:

;(use-package lsp-mode
;  :ensure t
;  :commands lsp
;  :config (progn
;            (setq lsp-log-io t)
;            ))


;(use-package lsp-ui
;  :ensure t
;  :hook (erlang-mode . 'flycheck-mode)
;  :config (progn
            ;; (require 'lsp-imenu)
            ;; (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
;;
;)
;  :commands lsp-ui-mode)

;(use-package company-lsp
;  :ensure t
;  :config
;  (push 'company-lsp company-backends)
;  :commands company-lsp)

;(use-package lsp-ivy
;  :after ivy
;  )


;(use-package lsp-origami
;  :after (lsp-mode origami-mode)
;  )

(use-package eglot
  :ensure t
  )

(provide 'prog-mode-init)

;;; prog-mode-init.el ends here
