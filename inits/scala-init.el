;;; scala-init.el ---



;;; Commentary:
;;

;;; Code:

(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode))

(use-package sbt-mode
  :ensure t
  )

(provide 'scala-init)

;;; scala-init.el ends here
