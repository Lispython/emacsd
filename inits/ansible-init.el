;;; ansible-init.el --- Ansible support

;;; Commentary:
;;


;;; Code:

(use-package ansible
  :ensure t
  :init (add-hook 'yaml-mode-hook '(lambda () (ansible 1))))

(use-package ansible-doc
  :ensure t)

(provide 'ansible-init)

;;; ansible-init.el ends here
