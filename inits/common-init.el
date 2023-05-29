;;; common-init.el --- Define and configure common functions


;;; Commentary:
;;

;;; Code:

;; (add-to-list 'image-types 'svg)

;; overriding image.el function image-type-available-p
;; (defun image-type-available-p (type)
;;   "Return t if image type TYPE is available.
;; Image types are symbols like `xbm' or `jpeg'."
;;   (if (eq 'svg type)
;;       nil
;;     (and (fboundp 'init-image-library)
;;          (init-image-library type))))


(use-package rainbow-mode
  :ensure t
  )


(use-package multiple-cursors
  :ensure t
  :config (progn
            (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
            (global-set-key (kbd "C->") 'mc/mark-next-like-this)
            (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
            (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
            (global-unset-key (kbd "M-<down-mouse-1>"))
            (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
            ))

(use-package bm
  :ensure t
  )


(global-unset-key (kbd "C-3"))
(global-set-key (kbd "C-3") nil)
(global-set-key (kbd "M-3") nil)


(use-package swiper-helm
  :ensure t
  :config (progn
            (global-set-key (kbd "C-3 h") 'swiper-helm)))

(use-package swiper
  :ensure t
  :config (progn
            (setq ivy-count-format "(%d/%d) ")
            ;; (global-set-key "\C-s" 'swiper)
            (global-set-key (kbd "C-c u") 'swiper-all)
            (global-set-key (kbd "C-3 s") 'swiper)
            (global-set-key (kbd "C-s") 'swiper)

            (global-set-key [C-tab-s] 'swiper)

            ))


;; (-package helm
;;   :config (setq helm-make-completion-method 'ivy)
;; )


(use-package counsel
  :ensure t
  :after (ivy))

(use-package ivy
  :ensure t
  :config (progn
            (with-temp-message "Setup ivy mode")
            (ivy-mode t)
            (setq ivy-use-virtual-buffers t)
            (setq enable-recursive-minibuffers t)

            (setq counsel-ag-command (list "ag" "--hidden" "--vimgrep" "%s"))
            (setq counsel-ag-base-command (list "ag" "--hidden" "--vimgrep" "%s"))

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

(use-package ivy-hydra
  :ensure t
  )

;;; Показывает буфер с найденными совпадениями
(defun occur-selection ()
  (interactive)
  (when (region-active-p)
    (let (deactivate-mark)
      (occur (regexp-quote (buffer-substring (region-beginning) (region-end)))))))


(global-set-key (kbd "C-c o") 'occur-selection)


(use-package expand-region
  :ensure t
  :config (global-set-key (kbd "C-=") 'er/expand-region)
  )


(use-package ivy-todo
  :ensure t
  ;; :bind ("C-c t" . ivy-todo)
  :commands ivy-todo
  :config
  (setq ivy-todo-default-tags '("PROJECT")))


(use-package helm-swoop
  :ensure t
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
  :ensure t
  :config (global-command-log-mode)
  )


(use-package undo-tree
  :ensure t
  :config (progn
            (global-undo-tree-mode)
            (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
            ))


(use-package origami
  :ensure t
  :config (progn
            (global-origami-mode)
            (define-key origami-mode-map (kbd "M-E") 'origami-toggle-node)
            (define-key origami-mode-map (kbd "M-Q") 'origami-open-all-nodes)
            (define-key origami-mode-map (kbd "M-W") 'origami-close-all-nodes)))

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

(use-package look-mode
  :ensure t
  )

(use-package regex-tool
  :ensure t
  )

(use-package free-keys
  :ensure t
  )


;; (use-package vterm
;;   :ensure t
;;   )

;; (use-package multi-term
;;   :ensure t
;;   )

;; (use-package hide-region)

;; (global-set-key (kbd "C-c h r") 'hide-region-hide)
;; (global-set-key (kbd "C-c h u") 'hide-region-unhide)


;;; Comment and uncomment function
(defun comment-or-uncomment-this (&optional lines)
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
		(comment-or-uncomment-region (point) (mark)))
	(comment-or-uncomment-region
	 (line-beginning-position)
	 (line-end-position lines))))


;; (use-package commandor)

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :after all-the-icons
  :init (progn
          (setq doom-modeline-height 24)
          (setq doom-modeline-icon t)
          (setq doom-modeline-major-mode-color-icon t)
          (setq doom-modeline-lsp t)

          (setq doom-modeline-env-version t)
          (doom-modeline-mode 1)

          ;; (setq doom-modeline-env-enable-python t)
          ;; (setq doom-modeline-env-enable-ruby t)
          ;; (setq doom-modeline-env-enable-perl t)
          ;; (setq doom-modeline-env-enable-go t)
          ;; (setq doom-modeline-env-enable-elixir t)
          ;; (setq doom-modeline-env-enable-rust t)
          ;; (setq doom-modeline-env-python-executable "python")
          ;; (setq doom-modeline-env-ruby-executable "ruby")
          ;; (setq doom-modeline-env-perl-executable "perl")
          ;; (setq doom-modeline-env-go-executable "go")
          ;; (setq doom-modeline-env-elixir-executable "iex")
          ;; (setq doom-modeline-env-rust-executable "rustc")

          ;; (setq doom-modeline-before-update-env-hook nil)
          ;; (setq doom-modeline-after-update-env-hook nil)
          )
  )


(use-package all-the-icons-ivy
  :ensure t
  :after all-the-icons
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package direnv
  :ensure t
  )

(use-package wgrep
  :ensure t
  )



(provide 'common-init)

;;; common-init.el ends here
