;;; magit-init.el ---



;;; Commentary:
;;

;;; Code:


(use-package magit
  :ensure t
  :config (progn
            (global-set-key (kbd "C-x g") 'magit-status)
            (setq magit-save-repository-buffers nil)
            ))

(use-package magit-todos
  :ensure t
  :after magit)

;; (use-package forge
;;   :after magit)

(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)


(provide 'magit-init)

;;; magit-init.el ends here
