;;; yasnippet-init.el --- Configure yasnippet package

;;; Commentary:
;;

;;; Code:

(use-package yasnippet
  :ensure t

  ;;:load-path ("~/.emacs.d/ext/yasnippet")
  ;;:load-path (concat **emacs-ext-dir** "yasnippet")
;;; WARNING
;;; yas/ replaced to yas-
  :config (progn
            (message "Loading yasnippet config")
            (yas-initialize)

            ;;(setq yas/snippet-dirs '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets"))
            ;;(setq yas/snippet-dirs '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets"))

            (setq yas-snippet-dirs '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets"))
            ;;(setq yas/root-directory '("~/.emacs.d/ext/yasnippet/snippets" "~/.emacs.d/snippets" ))

            ;; Map `yas/load-directory' to every element
            ;;(mapc 'yas/load-directory yas/root-directory)
            (yas-global-mode 1)
            (use-package react-snippets
              :ensure t
              )


            (eval-after-load "company"
              '(progn
                 ;; (add-to-list 'company-backends 'company-yasnippet)
                 (global-set-key (kbd "C-c y") 'company-yasnippet)

                 (push '(company-semantic :with company-yasnippet) company-backends)

                 )
              )
            ))


(use-package yasnippet-snippets
  :ensure t
  :config (yasnippet-snippets-initialize)
  )


(provide 'yasnippet-init)

;;; yasnippet-init.el ends here
