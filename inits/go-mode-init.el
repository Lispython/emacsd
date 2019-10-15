;;; go-mode-init.el ---

;;; Commentary:
;;

;;; Code:


(use-package go-mode
  :ensure t
  )


(use-package company-go
  :ensure t
  :config (progn
            (add-hook 'go-mode-hook
                      (lambda ()
                        (set (make-local-variable 'company-backends) '(company-go))
                        (company-mode)))
            ))



(provide 'go-mode-init)

;;; go-mode-init.el ends here
