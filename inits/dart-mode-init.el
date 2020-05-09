;;; dart-mode-init.el ---

;;; Commentary:
;;

;;; Code:



(use-package dart-mode
  :ensure t
  ;; :hook (dart-mode . flutter-test-mode)
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
            ;; (add-to-list 'eglot-server-programs '(dart-mode . ("dart_language_server")))

            (add-to-list 'eglot-server-programs '(dart-mode . ("dart_language_server")))

            (add-hook 'dart-mode-hook 'eglot-ensure)
            )
  )


;; Dir locals customization
;; ((dart-mode
;;   (flutter-l10n-classname . "AppLocalizations")
;;   (flutter-l10n-file . "lib/app_l10n.dart")))

(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "/Applications/flutter/"))


(use-package flutter-l10n-flycheck
  :after flutter
  :config
  (flutter-l10n-flycheck-setup))


(provide 'dart-mode-init)

;;; dart-mode-init.el ends here
