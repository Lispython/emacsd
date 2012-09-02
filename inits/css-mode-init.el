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
(defun ac-css-mode-candidates ()
  "thisandthat."
  (list "mymode" "mymode candi" "another candidate" "mymode2 csss")
)

(defun ac-css-mode-documentation (item)
  (if (stringp item)
    (let (s)
      (setq s "help text string")

    ))
)


(ac-define-source css-mode-r
  '((candidates . ac-css-mode-candidates)
    (document . ac-css-mode-documentation)
;;    (prefix . ac-css-prefix)
    (requires . 0)))


(add-hook 'css-mode-hook (lambda ()
						   (message "css mode hook")
				           (rainbow-mode t)
                           (setq ac-sources (append '(ac-source-css-property) ac-sources))
                           (setq ac-sources (append '(ac-source-css-mode-r) ac-sources))
						   (if css-menu (easy-menu-add css-menu))

;;(setq ac-sources (append '(ac-source-css-property) ac-sources))
;;						   (setq ac-sources '(ac-source-css-property))
))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)))