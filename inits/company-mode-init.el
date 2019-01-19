;;; company-mode-init.el ---

;;; Commentary:
;;




  (defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))


  (defun indent-or-complete ()
    (interactive)
    (if (looking-at "\\_>")
        (company-complete-common)
      (indent-according-to-mode)))



(provide 'company-mode-init)

;;; company-mode-init.el ends here
