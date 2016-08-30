;;; Flycheck inits

;;;Code:
 (setq flycheck-flake8rc (concat **emacs-dir** "flycheck/.flake8rc"))


(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(provide 'flycheck-init)
;;; flycheck-init.el ends here
