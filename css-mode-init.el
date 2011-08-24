(defvar css-menu nil
  "Menu for CSS Mode.
This menu will get created automatically if you have the `easymenu'
package.  Note that the latest X/Emacs releases contain this package.")

(easy-menu-define
  css-menu cssm-mode-map "CSS Mode menu"
  '("CSS"
	["Add comment" cssm-insert-comment]
	["Insert url" cssm-insert-url]
	["Insert brace" cssm-insert-right-brace-and-indent]
	["Complete property" cssm-complete-property]
    "-----"
	))

;;(when (require 'auto-complete nil t))

(add-hook 'css-mode-hook (lambda ()
						   (message "css mode hook")
				           (rainbow-mode t)
                           (setq ac-sources (append '(ac-source-css-property) ac-sources))
						   (if css-menu (easy-menu-add css-menu))

;;(setq ac-sources (append '(ac-source-css-property) ac-sources))
;;						   (setq ac-sources '(ac-source-css-property))
))

(provide 'css-mode-init)