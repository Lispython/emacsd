;;; saltstack-init.el ---


;;; Commentary:
;;

;;; Code:

(use-package yaml-mode)

(use-package salt-mode
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.sls\\'" . saltstack-mode))
            (add-hook 'salt-mode-hook
                      (lambda ()
                        (flyspell-mode 1)))))

(provide 'saltstack-init)



;;; saltstack-init.el ends here
