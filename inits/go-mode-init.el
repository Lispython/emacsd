;;; go-mode-init.el ---

;;; Commentary:
;;

;;; Code:


(use-package go-mode)


(use-package company-go
  :config (progn
            (add-hook 'go-mode-hook
                      (lambda ()
                        (set (make-local-variable 'company-backends) '(company-go))
                        (company-mode)))
                  ))



(provide 'go-mode-init)

;;; go-mode-init.el ends here
