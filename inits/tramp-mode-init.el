;;; tramp-mode-init.el ---

;;; Commentary:
;;

;;; Code:

(use-package tramp
  :init (setq tramp-default-method "ssh"))

(use-package vagrant-tramp)


(provide 'tramp-mode-init)

;;; tramp-mode-init.el ends here
