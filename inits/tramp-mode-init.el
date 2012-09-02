(message "tramp initialization")

(setq tramp-default-method "ssh")

;; HOOKS

(add-hook 'tramp-mode-hook
	  (lambda ()
	    (message "tramp hook")))

(message "tramp mode init loaded")