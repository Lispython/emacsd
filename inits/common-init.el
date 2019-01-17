;;; common-init.el --- Define and configure common functions



;;; Commentary:
;;

;;; Code:

(use-package multiple-cursors

  :config (progn
            (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
            (global-set-key (kbd "C->") 'mc/mark-next-like-this)
            (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
            (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
            (global-unset-key (kbd "M-<down-mouse-1>"))
            (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
            ))

(use-package bm)


(global-unset-key (kbd "C-3"))
(global-set-key (kbd "C-3") nil)


(use-package swiper-helm

  :config (progn
            (with-temp-message "Setup swiper helm")
            (global-set-key (kbd "C-3 h") 'swiper-helm)))

(use-package swiper

  :config (progn
            (with-temp-message "Setup swiper")

            (setq ivy-count-format "(%d/%d) ")
            (global-set-key (kbd "C-3 s") 'swiper)))


;; (use-package helm
;;   :config (setq helm-make-completion-method 'ivy)
;; )

(use-package ivy
  :config (progn
            (with-temp-message "Setup ivy mode")
            (ivy-mode t)
            (setq ivy-use-virtual-buffers t)
            (setq enable-recursive-minibuffers t)

            (global-set-key (kbd "C-c C-r") 'ivy-resume)

            (setq ivy-re-builders-alist
                  '((read-file-name-internal . ivy--regex-fuzzy)
                    (t . ivy--regex-plus)))
            ))


(use-package ivy-rich
  :ensure t
  :config (progn
            (ivy-rich-mode 1)
            (setq ivy-rich-path-style 'abbrev)
            ))

(provide 'common-init)

;;; common-init.el ends here
