;;; magit-init.el ---



;;; Commentary:
;;

;;; Code:

(use-package magit
  :config (progn
            (global-set-key (kbd "C-x g") 'magit-status)))

(provide 'magit-init)

;;; magit-init.el ends here
