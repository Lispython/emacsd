;;; dart-mode-init.el ---

;;; Commentary:
;;

;;; Code:



(use-package dart-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
            ;; (add-to-list 'eglot-server-programs '(dart-mode . ("dart_language_server")))

            )
  )





(provide 'dart-mode-init)

;;; dart-mode-init.el ends here
