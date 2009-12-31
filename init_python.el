(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'python-mode)

(add-hook 'python-mode-hook
		  (lambda ()
			(set-variable 'py-indent-offset 4)

			(set-variable 'indent-tabs-mode nil)
			(define-key py-mode-map (kbd "RET") 'newline-and-indent)
			(smart-operator-mode-on)))

(provide 'init_python)

