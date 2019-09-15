;;; erlang-init.el ---


;;; Commentary:
;;

;;; Code:

(add-to-list 'load-path "~/.emacs.d/ext/distel/elisp/")


(use-package erlang-start

  :config (progn
            (add-hook 'erlang-mode-hook #'smartparens-mode)
            (add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
            (add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

            (setq erlang-root-dir "/opt/local/lib/erlang")
            (add-to-list 'exec-path "/opt/local/lib/erlang/bin")
            (setq erlang-man-root-dir "/opt/local/lib/erlang/man")

            (add-hook 'erlang-mode-hook
                      (lambda ()
                        ;; when starting an Erlang shell in Emacs, the node name
                        ;; by default should be "emacs"
                        (setq inferior-erlang-machine-options '("-sname" "emacs"))
                        ;; add Erlang functions to an imenu menu
                        (imenu-add-to-menubar "imenu")))
            ))

(require 'distel)
(distel-setup)

(use-package company-distel
   :config (progn
             (add-to-list 'company-backends 'company-distel)))


(provide 'erlang-init)

;;; erlang-init.el ends here
