(require 's)
(require 'f)
(require 'python-mode)


(defgroup python-mode-pyenv nil
  "Pyenv virtualenv integration with python mode."
  :group 'languages)


(defcustom python-mode-pyenv-mode-mode-line-format
  '(:eval
    (when (python-mode-pyenv-version)
      (concat "Pyenv:" (python-mode-pyenv-version) " ")))
  "How `pyenv-mode' will indicate the current python version in the mode line."
  :group 'python-mode-pyenv)

(defun python-mode-pyenv-version ()
  "Return currently active pyenv version."
  (getenv "PYENV_VERSION"))

(defun python-mode-pyenv-root ()
  "Pyenv installation path."
  (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv root")))

(defun python-mode-pyenv-full-path (version)
  "Return full path for VERSION."
  (unless (string= version "system")
    (concat (python-mode-pyenv-root) "/versions/" version)))

(defun python-mode-pyenv-versions ()
  "List installed python versions."
  (let ((versions (shell-command-to-string "pyenv versions --bare")))
    (cons "system" (split-string versions))))

(defun python-version-found (python-mode-pyenv-version-path)
  "Python version found callback"
  (message (concat "Python version found: " python-mode-pyenv-version-path))
  (python-mode-pyenv-set (s-trim (f-read-text python-mode-pyenv-version-path))))


(defun python-mode-pyenv-read-version ()
  "Read virtual environment from user input."
  (completing-read "Pyenv: " (python-mode-pyenv-versions)))

;;;###autoload
(defun python-mode-pyenv-set (version)
  "Set python shell VERSION."
  (interactive (list (python-mode-pyenv-read-version)))
  (virtualenv-activate (python-mode-pyenv-full-path version))
  (setenv "PYENV_VERSION" version)
  (message (concat "Pyenv mode set: " version))
  )

;;;###autoload
(defun python-mode-pyenv-unset ()
  "Unset python shell version."
  (interactive)
  (virtualenv-deactivate)
  (setenv "PYENV_VERSION")
  (message "Pyenv mode unset")
  )


;; ;;;###autoload
;; (define-minor-mode python-mode-pyenv
;;   "Minor mode for python-mode pyenv interaction.

;; \\{python-mode-pyenv-map}"
;;   :global t
;;   :lighter ""
;;   :keymap python-mode-pyenv-map
;;   (if python-mode-pyenv
;;       (add-to-list 'mode-line-misc-info python-mode-pyenv-mode-mode-line-format)
;;     (setq mode-line-misc-info
;;           (delete python-mode-pyenv-mode-mode-line-format mode-line-misc-info))))


(defun python-mode-env-auto-hook ()
  "Automatically activated python-mode env if .python-version file exists."

  (message "Python-mode env try to find .python-mode")

  (f-traverse-upwards
   (lambda (path)
     (let ((pyenv-version-path (f-expand ".python-version" path)))
       (message (concat "Test " pyenv-version-path))
       (if (f-exists? pyenv-version-path)
           (python-version-found pyenv-version-path)))))

  )

;;(add-hook 'find-file-hook 'python-mode-env-auto-hook)

(provide 'python-mode-env)

;;; python-mode-env.el end here
