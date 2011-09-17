
(defun ac-go-mode-candidates ()
  "thisandthat."
  go-mode-keywords
)
(defun ac-go-mode-documentation (item)
  (if (stringp item)
    (let (s)
      (setq s "help text string")
    ))
)

(ac-define-source go-mode
  '((candidates . ac-go-mode-candidates)
    (document . ac-go-mode-documentation)
;;    (prefix . ac-css-prefix)
    (requires . 0)))

(add-hook 'go-mode-hook (lambda ()
						  (message "GO mode hook")
						  (setq ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))

;;						  (setq ac-sources (append '(ac-source-go-mode) ac-sources))
						  ))

(provide 'go-mode-init)