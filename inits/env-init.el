;;; env-init.el --- Summary

;;; Commentary:
;;

;;; Code:

(defconst **brew-root** "/usr/local")
(defconst **brew-bin** (concat **brew-root** "/bin"))


(defun add-to-PATH (dir)
  "Add the specified DIR element to the Emacs PATH."
  (interactive "DEnter directory to be added to PATH: ")
  (if (file-directory-p dir)
      (progn
        (setenv "PATH"
                (concat (expand-file-name dir)
                      path-separator
                      (getenv "PATH")))

        (add-to-list 'exec-path dir)
        )))

(add-to-PATH **brew-bin**)

(provide 'env-init)

;;; env-init.el ends here
