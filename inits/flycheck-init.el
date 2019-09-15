;;; Flycheck inits
(require 'flycheck)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config (progn
            (flycheck-add-mode 'javascript-eslint 'tide-mode)
            (flycheck-add-mode 'javascript-eslint 'js-mode)

            (add-to-list 'flycheck-checkers 'javascript-jshint 'append)
            (add-to-list 'flycheck-checkers 'jsx-tide 'append)
            (add-to-list 'flycheck-checkers 'typescript-tslint 'append)
            (add-to-list 'flycheck-checkers 'typescript-tide 'append)
            )
  )

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
  ;;(with-temp-message (format "flycheck-option-check-config-file-volume: %s" value))
  (let ((file-name (flycheck-locate-config-file value 'python-docker-flake8)))
    (unless (eq file-name nil)
      ;;(with-temp-message (format "flycheck-option-check-config-file-volume file-name: %s" file-name))

      (if (file-exists-p file-name)
          (progn
            ;;(with-temp-message (format "flycheck-option-check-config-file-volume file exists: %s" value))
            (format "%s:%s" file-name (concat "/usr/src/app/" value))

            )
        ;; (progn
        ;;   ;;(with-temp-message (format "flycheck-option-check-config-file-volume file not exists: %s" value))

        ;;   )
        ))))


(defun flycheck-option-config-file-eval (value)
  (with-temp-message (format "flycheck-option-config-file-eval: %s" value))

  (let ((file-name (flycheck-locate-config-file value 'python-docker-flake8)))
    (unless (eq file-name nil)
      (if (file-exists-p file-name)
          (progn
            ;; (with-temp-message (format "flycheck-option-config-file-eval file exists: %s" value))
            (format "--config=/usr/src/app/setup.cfg")
            )
        ))))

(flycheck-define-checker python-docker-flake8
  "A Python syntax checker"
  :command ("docker"
            "run"
            "--rm"
            "-i"
            (option "--volume=" flycheck-flake8rc concat flycheck-option-check-config-file-volume)

            ;;; TODO: add image options
            "emacsd"
            ;; "/bin/bash" "-c" "$(pyenv prefix 3.6.8)/bin/flake8"
            "/usr/bin/env.sh"
            "3.6.8"
            "flake8"

            "--format=default"

            (option "--max-complexity" flycheck-flake8-maximum-complexity nil
                    flycheck-option-int)
            (option "--max-line-length" flycheck-flake8-maximum-line-length nil
                    flycheck-option-int)

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


(flycheck-define-checker python-docker-mypy
  "Mypy syntax and type checker.  Requires mypy>=0.580.

See URL `http://mypy-lang.org/'."
  :command ("docker"
            "run"
            "--rm"
            "-i"
            (option "--volume=" flycheck-python-mypy-ini concat flycheck-option-check-config-file-volume)

            "emacsd"
            "mypy"
            "--show-column-numbers"
            (config-file "--config-file" flycheck-python-mypy-ini)
            (option "--cache-dir" flycheck-python-mypy-cache-dir)
            source-original)
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ": error:" (message)
          line-end)
   (warning line-start (file-name) ":" line ":" column  ": warning:" (message)
            line-end))
  :modes python-mode
  ;; Ensure the file is saved, to work around
  ;; https://github.com/python/mypy/issues/4746.
  :predicate flycheck-buffer-saved-p
  :next-checkers '(t . python-docker-flake8))


(defun flycheck-python-docker-setup ()
  (message "Flycheck python docker setup")
  (setq flycheck-flake8rc "setup.cfg")

  ;;(add-to-list 'flycheck-checkers 'python-docker-flake8)
  ;;(setq flycheck-python-docker-flake8-executable "")
  ;;(setq flycheck-python-flake8-executable "docker run --rm -i emacsd flake8")
  )


(add-hook 'python-mode-hook
          (lambda ()
            (progn
              (with-temp-message "Disable default python-mode flycheck checkers:")
              (dolist (checker '(python-flake8 python-pycompile python-mypy))
                (with-temp-message (format "    Disable checker %s for python-mode" checker))
                (add-to-list 'flycheck-disabled-checkers checker))
              (add-to-list 'flycheck-checkers 'python-docker-flake8 'append))))


(defun flycheck-python-docker-flake8-setup ()
  "Test mode switches"
  (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))
  (setq flycheck-flake8rc "setup.cfg")
  (add-to-list 'flycheck-disabled-checkers 'python-flake8)

  (add-to-list 'flycheck-checkers 'python-docker-flake8 'append)
  )


  ;; (when (derived-mode-p 'python-mode)
  ;;   (message "Flycheck python flacke mode check")
  ;;   ;; (add-hook 'hack-local-variables-hook
  ;;   ;;           #'flycheck-virtualenv-set-python-executables 'local))
  ;;   )

  ;; )


;;(flycheck-python-docker-setup)


(flycheck-python-docker-flake8-setup)


(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint
          (and root
               (expand-file-name "node_modules/.bin/eslint"
                                 root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)



(use-package hydra

  :config
  (defhydra hydra-flycheck
    (:pre (progn (setq hydra-lv t) (flycheck-list-errors))
          :post (progn (setq hydra-lv nil) (quit-windows-on "*Flycheck errors*"))
          :hint nil)
    "Errors"
    ("f"  flycheck-error-list-set-filter                            "Filter")
    ("j"  flycheck-next-error                                       "Next")
    ("k"  flycheck-previous-error                                   "Previous")
    ("gg" flycheck-first-error                                      "First")
    ("G"  (progn (goto-char (point-max)) (flycheck-previous-error)) "Last")
    ("q"  nil))

  )


(provide 'flycheck-init)
;;; flycheck-init.el ends here
