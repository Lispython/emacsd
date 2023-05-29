;;; Flycheck inits
(require 'flycheck)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config (progn
            (flycheck-add-mode 'javascript-eslint 'tide-mode)
            (flycheck-add-mode 'javascript-eslint 'js-mode)

            (add-to-list 'flycheck-checkers 'javascript-jshint 'append)
            (add-to-list 'flycheck-checkers 'jsx-tide 'append)
            (add-to-list 'flycheck-checkers 'typescript-tslint 'append)
            (add-to-list 'flycheck-checkers 'typescript-tide 'append)

               (eval-after-load 'flycheck
                 '(flycheck-package-setup))
            )
  )

(use-package flycheck-color-mode-line
  :ensure t
         )

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


;; We can safely declare this function, since we'll only call it in Python Mode,
;; that is, when python.el was already loaded.
;;(declare-function python-shell-calculate-exec-path "python")


(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint
          (and root
               (expand-file-name "node_modules/.bin/eslint"
                                 root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)



(use-package hydra
  :ensure t
  :config
  (defhydra hydra-flycheck
    (:pre (progn (setq hydra-lv t) (flycheck-list-errors))
          :post (progn (setq hydra-lv nil) (quit-windows-on "*Flycheck errors*"))
          :hint nil)
    "Errors"
    ("f"  flycheck-error-list-set-filter                            "Filter")
    ("j"  flycheck-next-error                                       "Next")
    ("k"  flycheck-previous-error                                   "Previous")
    ("gg" flycheck-first-error                                      "First")
    ("G"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
    ("q"  nil))

  )


(provide 'flycheck-init)
;;; flycheck-init.el ends here
