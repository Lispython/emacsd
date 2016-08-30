;;; Flycheck inits

;;;Code:
 (setq flycheck-flake8rc (concat **emacs-dir** "flycheck/.flake8rc"))


(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "dark red" :weight bold)))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "dark red" :weight bold))))
 '(flycheck-warning ((t (:background "gold1" :distant-foreground "Purple" :foreground "Red")))))


(provide 'flycheck-init)
;;; flycheck-init.el ends here
