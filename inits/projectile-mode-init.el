;;; projectile-mode-init.el ---




;;; Commentary:
;;

;;; Code:


(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode t)
  (setq projectile-project-search-path '("~/github/projects/"))
  (setq projectile-completion-system 'ivy))


(use-package counsel-projectile
  :config (progn
            (counsel-projectile-mode)
            ))


;;(use-package projectile-speedbar)


(provide 'projectile-mode-init)

;;; projectile-mode-init.el ends here
