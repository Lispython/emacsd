;;; multiple-cursors-ini.el ---

;;; Commentary:
;;

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))


(use-package multiple-cursors

  :config (progn ;; Should be able to eval-and-replace anywhere.
            (global-set-key (kbd "C-c C-e") 'eval-and-replace)
            (global-set-key (kbd "M-s-e") 'eval-and-replace)))

(provide 'multiple-cursors-init)

;;; multiple-cursors-init.el ends here
