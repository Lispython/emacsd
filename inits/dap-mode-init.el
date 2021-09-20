;;; dap-mode-init.el ---

;;; Commentary:
;;

;;; Code:

(use-package dap-mode
  :ensure t
  :config
  (delete 'tooltip dap-auto-configure-features)
  (dap-mode t)
  (dap-ui-mode t))



(provide 'dap-mode-init)

;;; dap-mode-init.el ends here
