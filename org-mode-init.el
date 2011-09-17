(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

(setq org-todo-keywords '((type "TODO" "NEXT" "WAITING" "DONE")))

;; color-code task types.

(setf org-todo-keyword-faces '(("NEXT" . (:foreground "yellow" :background "red" :bold t :weight bold))
			       ("TODO" . (:foreground "cyan" :background "steelblue" :bold t :weight bold))
			       ("WAITING" . (:foreground "yellow" :background "magenta2" :bold t :weight bold))
			       ("DONE" . (:foreground "gray50" :background "gray30"))))


(add-hook 'org-mode-hook (lambda ()
						   (message "org mode hook")
                           (set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
                           ;; yasnippet (allow yasnippet to do it's thing in org files)
                           (org-set-local 'yas/trigger-key [tab])
                           (define-key yas/keymap [tab] 'yas/next-field-group)
))


(provide 'org-mode-init)