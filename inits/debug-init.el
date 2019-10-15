;;; debug-init.el --- Summary

;;; Commentary:


;;; Code:

(defun load-debug-functions ()
  "Load debug functions."
  ;; (setq flycheck-python-flake8-executable (concat **emacs-dir** "venv/bin/flake8"))
  ;; (setq flycheck-flake8rc "setup.cfg")
  ;; (with-temp-message "Debug functions loading ...")

  ;; (add-hook 'python-mode-hook
  ;;           (lambda ()
  ;;             (progn
  ;;               (with-temp-message "disabled flycheck checkers:")
  ;;               (dolist (checker flycheck-disabled-checkers)
  ;;                 (message ">>>disabled checher: %s" checker)))))

  ;; (add-hook 'focus-in-hook
  ;;           (lambda ()
  ;;             (with-temp-message (format "Focus on hook: %s" major-mode))))

  ;; (add-hook 'focus-out-hook
  ;;           (lambda ()
  ;;             (with-temp-message (format "Focus out hook: %s" major-mode))))
  )

(load-debug-functions)


(provide 'debug-init)

;;; debug-init.el ends here
