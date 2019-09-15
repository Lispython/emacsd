;;; magit-init.el ---



;;; Commentary:
;;

;;; Code:


(use-package magit
  :config (progn
            (global-set-key (kbd "C-x g") 'magit-status)
            ))

(use-package magit-todos)



(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)


(provide 'magit-init)

;;; magit-init.el ends here
