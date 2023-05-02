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

            ;; (add-to-list 'eglot-server-programs '(dart-mode . ("dart_language_server")))

            (add-hook 'dart-mode-hook 'lsp)

            (setq gc-cons-threshold (* 100 1024 1024)
                  read-process-output-max (* 1024 1024))
            ;; (add-hook 'dart-mode-hook 'eglot-ensure)
            )
  )

(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp)
  ;; :init
  ;; (dap-register-debug-template "Flutter :: Custom debug"
  ;;                              (list :flutterPlatform "x86_64"
  ;;                                    :program "lib/main_debug.dart"
  ;;                                    :args '("--flavor" "customer_a")))

  )

;; Dir locals customization
;; ((dart-mode
;;   (flutter-l10n-classname . "AppLocalizations")
;;   (flutter-l10n-file . "lib/app_l10n.dart")))

(use-package flutter
  :ensure t
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "/Users/alexandr/github/env/flutter/"))


(use-package flutter-l10n-flycheck
  :ensure t
  :after flutter
  :config
  (flutter-l10n-flycheck-setup))


(provide 'dart-mode-init)

;;; dart-mode-init.el ends here
