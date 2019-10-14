;;; docker-init.el ---

;;; Commentary:
;;


;;; Code:

;; (use-package docker-compose-mode)


(use-package docker
  :ensure t
  :bind ("C-c d" . docker)
  )

;;; TODO: configure company-autocomplete

(provide 'docker-init)

;;; docker-init.el ends here
