;;; highlight-symbol-init.el ---
;; (require 'highlight-symbol)

;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; (provide 'highlight-symbol-init)


;;; Commentary:
;;

;;; Code:

;; (use-package highlight-symbol
;;   :config (progn
;;             ;; (set-face-attribute 'highlight-symbol-face nil
;;             ;;                     :background "default"
;;             ;;                     :foreground "#FA009A")
;;             (setq highlight-symbol-idle-delay 0)
;;             (setq highlight-symbol-on-navigation-p t)
;;             (add-hook 'prog-mode-hook #'highlight-symbol-mode)
;;             (add-hook 'prog-mode-hook #'highlight-symbol-nav-mode)

;;             (global-set-key [(control f3)] 'highlight-symbol)
;;             (global-set-key [f3] 'highlight-symbol-next)
;;             (global-set-key [(shift f3)] 'highlight-symbol-prev)
;;             (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;;             ))

(use-package auto-highlight-symbol
  :config (progn
            (global-auto-highlight-symbol-mode t)
            (setq ahs-idle-interval 0.1)
            ;; (define-key auto-highlight-symbol-mode-map (kbd "M-p") 'ahs-backward)
            ;; (define-key auto-highlight-symbol-mode-map (kbd "M-n") 'ahs-forward)
            ))


;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'highlight-symbol-init)

;;; highlight-symbol-init.el ends here
