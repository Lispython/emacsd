;;; yaml-mode-init.el ---


;;; Commentary:
;;

;;; Code:

(use-package yaml-mode
  :ensure t
  :config (progn
            (message "yaml-mode config init")
            (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
            (add-hook 'yaml-mode-hook
                      '(lambda ()
                         (define-key yaml-mode-map "\C-m" 'newline-and-indent)))))


(provide 'yaml-mode-init)

;;; yaml-mode-init.el ends here
