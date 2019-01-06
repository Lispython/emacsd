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
(declare-function python-shell-calculate-exec-path "python")

(defun flycheck-virtualenv-set-python-executables ()
  "Set Python executables for the current buffer."
  (message "Flycheck virtualenv activate")

  (let ((exec-path (python-shell-calculate-exec-path)))
    (setq-local flycheck-python-pylint-executable
                (executable-find "pylint"))
    (setq-local flycheck-python-flake8-executable
                (executable-find "flake8"))))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (when (derived-mode-p 'python-mode)
    (add-hook 'hack-local-variables-hook
              #'flycheck-virtualenv-set-python-executables 'local)))



;; (flycheck-define-checker python-flake8
;;   "A Python syntax and style checker using Flake8.
;; Requires Flake8 3.0 or newer. See URL
;; `https://flake8.readthedocs.io/'."
;;   :command ("flake8"
;;             "--format=default"
;;             "--stdin-display-name" source-original
;;             (config-file "--config" flycheck-flake8rc)
;;             (option "--max-complexity" flycheck-flake8-maximum-complexity nil
;;                     flycheck-option-int)
;;             (option "--max-line-length" flycheck-flake8-maximum-line-length nil
;;                     flycheck-option-int)
;;             "-")
;;   :standard-input t
;;   :error-filter (lambda (errors)
;;                   (let ((errors (flycheck-sanitize-errors errors)))
;;                     (seq-do #'flycheck-flake8-fix-error-level errors)
;;                     errors))
;;   :error-patterns
;;   ((warning line-start
;;             (file-name) ":" line ":" (optional column ":") " "
;;             (id (one-or-more (any alpha)) (one-or-more digit)) " "
;;             (message (one-or-more not-newline))
;;             line-end))
;;   :modes python-mode)


(require 'flycheck)

(flycheck-define-checker python-docker-flake8
  "A Python syntax and style checker using the docker flake8 utility.
See URL `http://pypi.python.org/pypi/pyflakes'."
  :command ("docker run --rm -i emacsd \"`pyenv prefix 2.7`/bin/flake8 --format=default --stdin-display-name\""
            source-original "-"
            )
  :standard-input t
  :error-patterns
  ((error line-start (file-name) ":" line ":" (message) line-end))
  :modes python-mode)



(defun flycheck-python-docker-setup ()
  (message "Flycheck python docker setup")
  (add-to-list 'flycheck-checkers 'python-docker-flake8)
  ;;(setq flycheck-python-docker-flake8-executable "")
  ;;(setq flycheck-python-flake8-executable "docker run --rm -i emacsd flake8")
  )


(defun flycheck-python-flake8-setup ()
  "Test mode switches"
  (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))
  (setq flycheck-flake8rc "setup.cfg")

  (add-hook 'python-mode-hook
            (lambda ()
              (message "Python mode hook work")
              (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))

              ))

  (add-hook 'focus-in-hook
            (lambda ()
              (message "Focus on hook: %s" major-mode)
              (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))
              ))

  )

  ;; (when (derived-mode-p 'python-mode)
  ;;   (message "Flycheck python flacke mode check")
  ;;   ;; (add-hook 'hack-local-variables-hook
  ;;   ;;           #'flycheck-virtualenv-set-python-executables 'local))
  ;;   )

  ;; )


;;(flycheck-python-docker-setup)

(flycheck-python-flake8-setup)

(provide 'flycheck-init)
;;; flycheck-init.el ends here
