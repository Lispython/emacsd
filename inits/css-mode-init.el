;;; css-mode-init.el ---

;;; Commentary:
;;

;;; Code:

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

(add-hook 'css-mode-hook (lambda ()
			   (message "css mode hook")
			   (rainbow-mode t)
			   (if css-menu (easy-menu-add css-menu))))


(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))


(provide 'css-mode-init)

;;; css-mode-init.el ends here
