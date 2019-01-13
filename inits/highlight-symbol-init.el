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

(use-package auto-highlight-symbol

  :config (global-auto-highlight-symbol-mode t))


;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'highlight-symbol-init)

;;; highlight-symbol-init.el ends here
