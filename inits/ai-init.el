;;; ai-init.el --- ai tools init file

;;; Commentary:
;;


;;; Code:


;; (add-subdirs-to-load-path (concat **emacs-ext-dir** "ai" ""))


(use-package ai
  :load-path (lambda () (concat **emacs-ext-dir** "ai"))
  :config (progn
            (global-set-key (kbd "C-<tab>") 'ai-complete-code-at-point)
            (global-ai-mode 1)
            (setq ai--query-type-map '(("translate-to-english" . "Translate to english: %s")
                                       ("fix" . "Here is a bug in the following function, please help me fix it: %s")
                                       ("improve" . "Improve and extend the following code: %s")
                                       ("explain" . "Объясни следующий код: %s")
                                       ("optimize" . "Optimize the following code: %s")
                                       ("spellcheck" . "Spellcheck this text: %s")
                                       ("elaborate" . "Elaborate on this text: %s")
                                       ("document" . "Please add the documentation for the following code: %s")
                                       ("refactor" . "Refactor the following code: %s")
                                       ))
            )
  )

(use-package ai-chat
  :load-path (lambda () (concat **emacs-ext-dir** "ai"))

  :config (progn

            )
  )

(use-package ob-ai
  :load-path (lambda () (concat **emacs-ext-dir** "ob-ai"))
  :config (progn
            (org-babel-do-load-languages 'org-babel-load-languages
                                         (append org-babel-load-languages '((ai . t))))
            (add-to-list 'org-src-lang-modes '("ai" . text))))

(provide 'ai-init)

;;; ai-init.el ends here
