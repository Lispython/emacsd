;;; erlang-init.el ---


;;; Commentary:
;;

;;; Code:

(add-to-list 'load-path "~/.emacs.d/ext/distel/elisp/")

(use-package ivy-erlang-complete
  :ensure t)


(use-package company-erlang
  :ensure t
  :hook (erlang-mode . company-erlang-init)
  )

(use-package erlang-start
  :ensure erlang
  :mode (("\\.erl?$" . erlang-mode)
	 ("rebar\\.config$" . erlang-mode)
	 ("relx\\.config$" . erlang-mode)
	 ("sys\\.config\\.src$" . erlang-mode)
	 ("sys\\.config$" . erlang-mode)
	 ("\\.config\\.src?$" . erlang-mode)
	 ("\\.config\\.script?$" . erlang-mode)
	 ("\\.hrl?$" . erlang-mode)
	 ("\\.app?$" . erlang-mode)
	 ("\\.app.src?$" . erlang-mode)
	 ("\\Emakefile" . erlang-mode))
  :hook ((after-save . ivy-erlang-complete-reparse)
         (erlang-mode . (lambda ()
                          (setq-local ivy-erlang-complete-project-root (projectile-project-root))
                          ))
         )
  :custom (ivy-erlang-complete-erlang-root "/usr/local/lib/erlang/")
  :config (progn
            (ivy-erlang-complete-init)
            (defvar inferior-erlang-prompt-timeout t)

            (add-hook 'erlang-mode-hook #'smartparens-mode)

            (setq erlang-root-dir "/usr/local/lib/erlang/")
            (add-to-list 'exec-path "/usr/local/lib/erlang/bin")
            (setq erlang-man-root-dir "/usr/local/lib/erlang/man")

            (add-hook 'erlang-mode-hook
                      (lambda ()
                        ;; when starting an Erlang shell in Emacs, the node name
                        ;; by default should be "emacs"
                        (setq inferior-erlang-machine-options '("-sname" "emacs"))
                        ;; add Erlang functions to an imenu menu
                        (imenu-add-to-menubar "imenu")))


            ;; tell distel to default to that node
            ;; (setq erl-nodename-cache (make-symbol (concat "emacs@" "localhost")))
            ;; (setq erl-nodename-cache
            ;;       (make-symbol
            ;;        (concat
            ;;         "emacs@"
            ;;         ;; Mac OS X uses "name.local" instead of "name", this should work
            ;;         ;; pretty much anywhere without having to muck with NetInfo
            ;;         ;; ... but I only tested it on Mac OS X.
            ;;         (car (split-string (shell-command-to-string "hostname"))))))

            ))


;; (use-package distel
;;   :config (progn
;;             (distel-setup)
;;             )
;;   )

;; (use-package company-distel
;;   :ensure t
;;   :config (progn
;;             (add-to-list 'company-backends 'company-distel)))


(use-package lsp-mode
  :ensure t
  :hook (erlang-mode . lsp)
  )

(use-package lsp-docker
  :config (progn
            (with-temp-message "Loading erlang lsp docker")
            )
  ;; :config (progn
  ;;           (with-temp-message "Loading lsp docker")
  ;;           (lsp-docker-register-client
  ;;            :server-id 'erlang-ls
  ;;            :priority 1
  ;;            :docker-server-id 'erlang-docker-ls
  ;;            :docker-image-id "yyoncho/lsp-emacs-docker"
  ;;            :docker-container-name "lsp-container"
  ;;            :server-command "erlang_ls"
  ;;            :path-mappings nil)

  ;;           )
  :after lsp-mode
  )

;; (use-package eglot
;;   :config (progn
;;             ;; (add-to-list 'eglot-server-programs '(erlang-mode . ("erlang_rs")))
;;             ;; (add-to-list 'eglot-server-programs . ("/tmp/erlang_ls/_build/default/bin/erlang_ls" 9998))
;;             (add-to-list 'eglot-server-programs
;;                          `(erlang-mode . ( "docker" "run" "--rm" "-i" "-p" "11119:11119" "lsp-erlang:latest" "erlang_ls" "11119")
;;                                        ))))

(provide 'erlang-init)

;;; erlang-init.el ends here
