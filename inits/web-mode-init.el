;; ; web-mode-init.el ---

;;; Commentary:
;;

(use-package web-mode
  :ensure t
  :config (progn

            (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))))


(use-package web-mode-edit-element
  :ensure t
  :config (progn
            (add-hook 'web-mode-hook 'web-mode-edit-element-minor-mode)))

(provide 'web-mode-init)

;;; web-mode-init.el ends he
