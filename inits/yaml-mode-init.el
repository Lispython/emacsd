(add-to-list 'load-path (concat **emacs-ext-dir** "yaml-mode/"))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(message "yaml-mode init loaded")