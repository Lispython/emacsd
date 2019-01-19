;;; dired-init.el ---

;;; Commentary:
;;


;;; Code:

(setq dired-listing-switches "-alh")


(use-package dired-rainbow

  :config (progn
            (message "Configure dired"))
            ; boring regexp due to lack of imagination
            (dired-rainbow-define log (:inherit default
                                       :italic t) ".*\\.log")

                                        ; highlight executable files, but not directories
            (dired-rainbow-define-chmod executable-unix "Green" "-[rw-]+x.*")
            (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
            ;; (dired-rainbow-define media "#ce5c00" my-dired-media-files-extensions)

            )



(use-package dired-collapse

  :config (progn
            (add-hook 'dired-mode-hook 'dired-collapse-mode)))

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(provide 'dired-init)

;;; dired-init.el ends here
