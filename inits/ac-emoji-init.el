(add-hook 'markdown-mode-hook 'ac-emoji-setup)
(add-hook 'git-commit-mode-hook 'ac-emoji-setup)

(set-fontset-font
 t 'symbol
 (font-spec :family "Apple Color Emoji") nil 'prepend)

(provide 'ac-emoji-init)
