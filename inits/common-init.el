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
            (global-set-key (kbd "C-c u") 'swiper-all)
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

            (ivy-set-occur 'ivy-switch-buffer 'ivy-switch-buffer-occur)

            (global-set-key (kbd "C-c C-r") 'ivy-resume)
            (global-set-key (kbd "C-c C-o") 'ivy-occur)

            (global-set-key (kbd "C-c C-r") 'ivy-resume)
            (global-set-key (kbd "<f6>") 'ivy-resume)
            (global-set-key (kbd "M-x") 'counsel-M-x)
            (global-set-key (kbd "C-x C-f") 'counsel-find-file)
            (global-set-key (kbd "<f2> f") 'counsel-describe-function)
            (global-set-key (kbd "<f2> v") 'counsel-describe-vaiable)
            (global-set-key (kbd "<f2> l") 'counsel-find-library)
            (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
            (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
            (global-set-key (kbd "C-c g") 'counsel-git)
            (global-set-key (kbd "C-c j") 'counsel-git-grep)
            (global-set-key (kbd "C-c k") 'counsel-ag)
            (global-set-key (kbd "C-x l") 'counsel-locate)
            (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
            (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

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

;; WARNING: broken icons
;; (use-package all-the-icons-ivy
;;   :config
;;   (all-the-icons-ivy-setup))

(use-package ivy-hydra)

;;; Показывает буфер с найденными совпадениями
(defun occur-selection ()
  (interactive)
  (when (region-active-p)
    (let (deactivate-mark)
      (occur (regexp-quote (buffer-substring (region-beginning) (region-end)))))))


(global-set-key (kbd "C-c o") 'occur-selection)


(use-package expand-region
  :config (global-set-key (kbd "C-=") 'er/expand-region)
)


(use-package helm-swoop
  :config (progn
            (global-set-key (kbd "M-i") 'helm-swoop)
            (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
            ;; (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
            ;;  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
            )
  )

;; (use-package historian
;;   :config (historian-mode +1)
;;   )


;; (use-package ivy-historian
;;   :config (progn
;;             (ivy-historian-mode +1)
;;             (setq ivy-historian-recent-boost most-positive-fixnum))
;;   )


(use-package command-log-mode
  :config (global-command-log-mode)
  )


(use-package undo-tree

  :config (progn
            (global-undo-tree-mode)
            ))


(use-package origami
  :config (progn
            (global-origami-mode)
            (define-key origami-mode-map (kbd "C-c f") 'origami-recursively-toggle-node)
            (define-key origami-mode-map (kbd "C-c F") 'origami-toggle-all-nodes)
            ))

;; (use-package sr-speedbar
;;   :config (progn
;;             (setq speedbar-show-unknown-files t)
;;             (setq speedbar-use-images nil)
;;             (setq sr-speedbar-right-side nil)
;;             (global-set-key (kbd "s-s") 'sr-speedbar-toggle)))


(use-package smartparens-config
  :ensure smartparens
  :config (progn
            (show-smartparens-global-mode t)
            (smartparens-global-mode)

            ;; (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
             ;; (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
            ;;(add-hook 'js-mode-hook #'smartparens-mode)
            )
)


(provide 'common-init)

;;; common-init.el ends here
