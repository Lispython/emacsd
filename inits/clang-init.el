
;; (require 'cedet-global)

;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode)

;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (semantic-mode t)
;;             (message "clang mode hook")
;;             (require 'ecb)
;;             (require 'semantic/ia)
;;             (require 'semantic/bovine/gcc)
;;             (global-ede-mode t)
;;             ))


;; (add-hook 'semantic-init-hooks
;;           (lambda ()
;;             (message "semantic init hooks")
;;             (imenu-add-to-menubar "TAGS")))

;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))


;; ;; Add autocomplete
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-gtags)
;;             (add-to-list 'ac-sources 'ac-source-semantic)
;;             ))

(provide 'clang-init)
;;; clang-init.el end here
