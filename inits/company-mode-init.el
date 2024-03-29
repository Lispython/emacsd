;;; company-mode-init.el ---

;;; Commentary:
;;


;;; Code:


(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))


(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))


(use-package company
  :ensure t
  :config (progn
            (add-hook 'after-init-hook 'global-company-mode)

            (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
            (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)

            (setq company-minimum-prefix-length 3 ; default is 3
                  ;; company-show-numbers          t
                  company-dabbrev-downcase      nil
                  company-dabbrev-ignore-case   nil

                  company-tooltip-limit 20 ; bigger popup window
                  company-idle-delay 0.1 ; decrease delay before autocompletion popup shows
                  company-echo-delay 0   ; remove annoying blinking
                                        ; company-begin-commands '(self-insert-command) ; start autocompletion only after typing
                  )

            ;; (set-face-attribute
            ;;  'company-preview
            ;;  nil
            ;;  :background (face-attribute 'company-preview-common :background)
            ;;  )

            ;; (custom-set-faces
            ;;  '(company-preview ((t (:foreground "darkgray" :underline t))))
            ;;  '(company-preview-common ((t (:inherit company-preview))))
            ;;  '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
            ;;  '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
            ;;  '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold))
            ;;                            (t (:inherit company-tooltip))))
            ;;  '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold))
            ;;                                      (t (:inherit company-tooltip-selection)))))
            ))



(use-package company-statistics
  :ensure t
  :config (progn
            (company-statistics-mode)))

(use-package company-quickhelp
  :ensure t
  :config (progn
            ;; (company-quickhelp-mode)
            (setq x-gtk-use-system-tooltips nil)
            (setq company-quickhelp-delay 0.05
                  company-quickhelp-max-lines 30
                  company-quickhelp-color-background "#fff5a5"
                  company-quickhelp-color-foreground "#000000"
                  company-quickhelp-use-propertized-text nil
                  pos-tip-background-color "#fff5a5"
                  pos-tip-foreground-color "#000000"

                  pos-tip-border-width 0)


            (define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin)))


(provide 'company-mode-init)

;;; company-mode-init.el ends here
