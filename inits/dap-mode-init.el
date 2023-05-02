;;; dap-mode-init.el ---

;;; Commentary:
;;

;;; Code:

(use-package dap-mode
  :ensure t
  :config (progn (delete 'tooltip dap-auto-configure-features)
                 (dap-mode t)
                 (dap-ui-mode t)

                 (require 'dap-cpptools)
                 ))



(provide 'dap-mode-init)

;;; dap-mode-init.el ends here
