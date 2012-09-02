(message "outline initialization")


;; HOOKS

(add-hook 'outline-mode-hook
	  (lambda ()
	    (message "outline hook")))

(message "outline mode init loaded")
