;;; ai-init.el --- ai tools init file

;;; Commentary:
;;


;;; Code:


;; (add-subdirs-to-load-path (concat **emacs-ext-dir** "ai" ""))


(use-package ai-mode
  :load-path (lambda () (concat **emacs-ext-dir** "ai"))
  :config (progn
            (setq ai-utils--verbose-log t)
            (global-set-key (kbd "C-<tab>") 'ai-completions--complete-at-point-with-limited-context)
            (global-set-key (kbd "C-M-<tab>") 'ai-completions--complete-at-point-with-full-context)
            (global-ai-mode 1)

            (add-hook 'prog-mode-hook #'ai-completions-mode)
            )
  )

(use-package ai-chat
  :load-path (lambda () (concat **emacs-ext-dir** "ai"))
  )

(use-package ob-ai
  :load-path (lambda () (concat **emacs-ext-dir** "ob-ai"))
  :config (progn
            (org-babel-do-load-languages 'org-babel-load-languages
                                         (append org-babel-load-languages '((ai . t))))
            (add-to-list 'org-src-lang-modes '("ai" . text))))


(use-package ai-mode-openai
  :load-path (lambda () (concat **emacs-ext-dir** "ai-mode-openai"))
  :after (ai-mode)
  :config (progn
            (setq ai-mode--models-providers (append ai-mode--models-providers '(ai-mode-openai--get-models)))
            (setq ai-chat--models-providers (append ai-chat--models-providers '(ai-mode-openai--get-models)))))


;; (use-package ai-mode-hf
;;   :load-path (lambda () (concat **emacs-ext-dir** "ai-mode-hf"))
;;   :config (progn
;;             (setq ai-mode--models-providers (append ai-mode--models-providers '(ai-mode-hf--get-models)))))


(use-package ai-mode-anthropic
  :load-path (lambda () (concat **emacs-ext-dir** "ai-mode-anthropic"))
  :after (ai-mode)
  :config (progn
            (setq ai-mode--models-providers (append ai-mode--models-providers '(ai-mode-anthropic--get-models)))
            (setq ai-chat--models-providers (append ai-chat--models-providers '(ai-mode-anthropic--get-models)))))




(provide 'ai-init)

;;; ai-init.el ends here
