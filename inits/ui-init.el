;;; ui-init.el ---




;;; Commentary:
;;

;;; Code:

(require 'ansi-color)

(require 'color-theme)


;;; Display line width indicator
(use-package fill-column-indicator
  :ensure t
  :config (progn ;;FILL

            (setq fci-rule-width 1)
            ;;(setq fci-rule-color "darkblue")
            (setq fci-rule-column 80)

            ;; (define-globalized-minor-mode global-fci-mode fci-mode
            ;;   (lambda () (fci-mode 1)))
            ;; (global-fci-mode 1)
            ))


;;; Current line hightlight
(global-hl-line-mode t)
;(set-face-background 'hl-line "#330")  ;; Emacs 22 Only

;THEMES


(use-package color-theme
  :ensure t
  :init (setq color-theme-is-global t)
  :config (progn
            ;; (setq color-theme-directory "~/.emacs.d/themes")

            (color-theme-initialize)
            (color-theme-solarized 'light)
            ;;(color-theme-solarized t)
            ;;(load-theme 'solarized t)
            ))


(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))


(provide 'ui-init)

;;; ui-init.el ends here
