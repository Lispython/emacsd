;;; js-mode-init.el ---

;;; Commentary:
;;

(require 'css-mode)
;; (require 'espresso)
;; (require 'django-html-mode)


;;; Code:


(use-package js2-mode
  :ensure t
  :config (progn
            (add-hook 'js-mode-hook 'js2-minor-mode)

            ;; (add-hook 'js2-mode-hook 'setup-tide-mode)

            (add-to-list 'auto-mode-alist '("\\.\\(js\\|es6\\)\\(\\.erb\\)?\\'" . js2-mode))
            (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
            (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))

            (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
            ;; (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
            ;; (add-to-list 'auto-mode-alist '("\\.tsx$" . js2-mode))
            (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))


            ;; (when (< emacs-major-version 27)
            ;;     (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
            ;;     (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode)))

            ;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
            ;; (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

            (setq js2-strict-missing-semi-warning nil)

            (setq js2-basic-offset 2)


            ;; (add-hook 'js-mode-hook (lambda ()
            ;;                           (flycheck-select-checker 'javascript-eslint)
            ;;                           ))

            ;; (add-hook 'js2-mode-hook 'tide-mode)

            ;; (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
            ;; (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

            ;; (setq js2-highlight-level 3
            ;;       js2-bounce-indent-p nil
            ;;       js2-include-node-externs t
            ;;       js2-skip-preprocessor-directives t
            ;;       js2-indent-switch-body nil
            ;;       js2-strict-missing-semi-warning nil
            ;;       js2-ignored-warnings nil
            ;;       js2-strict-trailing-comma-warning nil
            ;;       js2-mode-show-parse-errors nil
            ;;       js2-mode-show-strict-warnings nil)

            ))

(use-package rjsx-mode
  :ensure t
  :hook (rjsx-mode . tide-setup)
  :config (progn
            (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
            (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
            ;; (add-hook 'rjsx-mode-hook 'tide-setup)
            ;; (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . rjsx-mode))
            ))


(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config (progn
            ;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

            ;; (add-to-list 'auto-mode-alist '("\\.tsx$" . js-mode))

            (add-hook 'typescript-mode-hook #'tide-setup)

            ;; (flycheck-add-mode 'javascript-eslint 'tide-mode)
            ;; (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

            ;; (define-key tide-mode-map (kbd "s-b") 'tide-jump-to-definition)
            ;; (define-key tide-mode-map (kbd "s-[") 'tide-jump-back)
            )
  )

(use-package typescript-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
            (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))))


(use-package web-mode)


(add-hook 'espresso-mode-hook
          (lambda ()
            ;; (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
            (setq espresso-indent-level 2)))

;; enable typescript-tslint checker



(provide 'js-mode-init)

;;; js-mode-init.el ends here
