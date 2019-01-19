;;; ibuffer-mode-init.el ---

;;; Commentary:
;;

;;; Code:


(use-package ibuffer

  :config (progn
            (global-set-key (kbd "C-x C-b") 'ibuffer)

            ;; NOTIFY
            ;; Modify the default ibuffer-formats (toggle with `)

            (setq ibuffer-saved-filter-groups
                  (quote (("default"
	                   ("dired" (mode . dired-mode))
	                   ("erc" (mode . erc-mode))
	                   ("planner" (or
			               (name . "^\\*Calendar\\*$")
			               (name . "^diary$")
			               (mode . muse-mode)))
	                   ("emacs" (or
			             (name . "^\\*scratch\\*$")
			             (name . "^\\*Messages\\*$")))
	                   ("gnus" (or
			            (mode . message-mode)
			            (mode . bbdb-mode)
			            (mode . mail-mode)
			            (mode . gnus-group-mode)
			            (mode . gnus-summary-mode)
			            (mode . gnus-article-mode)
			            (name . "^\\.bbdb$")
			            (name . "^\\.newsrc-dribble")))))))



            ;;   (add-hook 'ibuffer-hook
;;     (lambda ()
;;       (ibuffer-vc-set-filter-groups-by-vc-root)
;;       (unless (eq ibuffer-sorting-mode 'alphabetic)
;;         (ibuffer-do-sort-by-alphabetic))))

            ))

(use-package ibuffer-vc

  :config (progn
            (message "Configure ibuffer vc")
            (define-ibuffer-column size-h
              (:name "Size" :inline t)
              (buffer-size)
              ; (file-size-human-readable (buffer-size))
              )
            (autoload 'ibuffer-make-column-vc-status "ibuffer-vc")
            (setq ibuffer-formats
                  '((mark modified read-only vc-status-mini
                          " " (name 22 22 :left :elide)
                          " " (size 9 -1 :right)
                          " " (mode 12 12 :left :elide)
                          " " vc-relative-file)
                    (mark modified read-only vc-status-mini
                          " " (name 22 22 :left :elide)
                          " " (size 9 -1 :right)
                          " " (mode 14 14 :left :elide)
                          " " (vc-status 12 12 :left)
                          " " vc-relative-file)
                    (mark modified read-only locked
                          " " (name 18 18 :left :elide)
			  " " (size 9 -1 :right)
			  " " (mode 16 16 :left :elide)
                          " " filename-and-process)
                    (mark " " (name 16 -1) " " filename)
                    ))
            ))


(provide 'ibuffer-mode-init)

;;; ibuffer-mode-init.el ends here
