;; (require 'highlight-symbol)

;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; (provide 'highlight-symbol-init)


(require 'auto-highlight-symbol )


(unless global-auto-highlight-symbol-mode
  (global-auto-highlight-symbol-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'highlight-symbol-init)
