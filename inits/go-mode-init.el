;;; go-mode-init.el ---

;;; Commentary:
;;

;;; Code:


(use-package go-mode

  :config (progn
            (add-hook 'go-mode-hook (lambda ()
			              (message "GO mode hook")))))

(provide 'go-mode-init)

;;; go-mode-init.el ends here
