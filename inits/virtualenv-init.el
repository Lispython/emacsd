;;; Setup ENV

;;(setenv "PYMACS_PYTHON" (concat **emacs-dir** "venv/bin/python"))
;;(defconst **venv-dir** (concat **emacs-dir** "venv"))


;; (defun activate-virtualenv (dir)
;;   (setenv "VIRTUAL_ENV" dir)
;;   (add-to-PATH (concat dir "/bin"))
;;   (add-to-list 'exec-path (concat dir "/bin")))


;; (defun add-to-PATH (dir)
;;   "Add the specified path element to the Emacs PATH"
;;   (interactive "DEnter directory to be added to PATH: ")
;;   (if (file-directory-p dir)
;;       (setenv "PATH"
;;               (concat (expand-file-name dir)
;;                       path-separator
;;                       (getenv "PATH")))))

;; ;; Add path
;; (activate-virtualenv **venv-dir**)
