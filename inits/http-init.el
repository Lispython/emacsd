;;; http-init.el ---

;;; http requests libraries

;;; Commentary:
;;

(use-package http-twiddle
  :ensure t
  )

(use-package restclient
  :ensure t
  ;; :config (add-to-list 'company-backends 'company-restclient)
  )

;;; Code:

(provide 'http-init)

;;; http-init.el ends here
