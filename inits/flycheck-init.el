;;; Flycheck inits
(require 'flycheck)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "dark red" :weight bold)))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "dark red" :weight bold))))
 '(flycheck-warning ((t (:background "gold1" :distant-foreground "Purple" :foreground "Red")))))


;; We can safely declare this function, since we'll only call it in Python Mode,
;; that is, when python.el was already loaded.
;;(declare-function python-shell-calculate-exec-path "python")


(defun flycheck-option-check-config-file-volume (value)
  (let ((file-name (flycheck-locate-config-file value 'python-docker-flake8)))
    (when (file-exists-p file-name)
      ;; (len ((config-filename (symbol-value value)))
      ;;      (message (format "flycheck-option-check-config-file-volume: %s" "bbb"))
      ;;      )

      ;;(message (format "File exists %s" (concat "/usr/src/app/" (symbol-value value))))
      (format "%s:%s" file-name "/usr/src/app/setup.cfg"))
    ))


(defun flycheck-option-config-file-eval (value)
  (message (format "configure flycheck-option-test-eval with value: %s -> " value))

  (let ((file-name (flycheck-locate-config-file value 'python-docker-flake8)))
    (when (file-exists-p file-name)
      ;;(format "--config=%s" (concat "/usr/src/app/" (symbol-value value)))
      (format "--config=/usr/src/app/setup.cfg")
      )))

(flycheck-define-checker python-docker-flake8
  "A Python syntax checker"
  :command ("docker"
            "run"
            "--rm"
            "-i"
            (option "--volume=" flycheck-flake8rc concat flycheck-option-check-config-file-volume)

            "emacsd"
            "/usr/bin/env.sh"
            "3.6.8"
            "flake8"

            "--format=default"

            "--no-isort-config"

            (option "--max-complexity" flycheck-flake8-maximum-complexity nil
                    flycheck-option-int)
            (option "--max-line-length" flycheck-flake8-maximum-line-length nil
                    flycheck-option-int)
            "--stdin-display-name=/usr/src/app/checking_file.py"

            (eval (flycheck-option-config-file-eval flycheck-flake8rc))

            "-"
            )
  :standard-input t
  :error-filter (lambda (errors)
                  (let ((errors (flycheck-sanitize-errors errors)))
                    (seq-do #'flycheck-flake8-fix-error-level errors)
                    errors))
  :error-patterns
  ((warning line-start
            "stdin:" line ":" (optional column ":") " "
            (id (one-or-more (any alpha)) (one-or-more digit)) " "
            (message (one-or-more not-newline))
            line-end))
  :modes python-mode)


(defun flycheck-python-docker-setup ()
  (message "Flycheck python docker setup")
  (setq flycheck-flake8rc "setup.cfg")

  ;;(add-to-list 'flycheck-checkers 'python-docker-flake8)
  ;;(setq flycheck-python-docker-flake8-executable "")
  ;;(setq flycheck-python-flake8-executable "docker run --rm -i emacsd flake8")
  )


(defun flycheck-python-docker-flake8-setup ()
  "Test mode switches"
  (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))
  (setq flycheck-flake8rc "setup.cfg")

  (add-hook 'python-mode-hook
            (lambda ()
              (message "Python mode hook work. Print some debug variable")))

  (add-hook 'focus-in-hook
            (lambda ()
              (message "Focus on hook: %s" major-mode))))


  ;; (when (derived-mode-p 'python-mode)
  ;;   (message "Flycheck python flacke mode check")
  ;;   ;; (add-hook 'hack-local-variables-hook
  ;;   ;;           #'flycheck-virtualenv-set-python-executables 'local))
  ;;   )

  ;; )


;;(flycheck-python-docker-setup)

(flycheck-python-docker-flake8-setup)

(provide 'flycheck-init)
;;; flycheck-init.el ends here
