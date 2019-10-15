;;; rust-mode-init.el ---


;;; Commentary:
;;

;;; Code:

;; (defun racer--call-override (command &rest args)
;;   (with-temp-message (format "racer-call ->> %s" command))
;;   (let ((rust-src-path (or (when racer-rust-src-path (expand-file-name racer-rust-src-path))
;;                            (getenv "RUST_SRC_PATH")))
;;         (cargo-home (or (when racer-cargo-home (expand-file-name racer-cargo-home))
;;                         (getenv "CARGO_HOME"))))
;;     (with-temp-message (format "||||>>>>> %s" rust-src-path))
;;     (with-temp-message (format "||||----> %s" cargo-home))
;;     (when (null rust-src-path)
;;       (user-error "You need to set `racer-rust-src-path' or `RUST_SRC_PATH'"))
;;     ;; (unless (file-exists-p rust-src-path)
;;     ;;   (user-error "No such directory: %s. Please set `racer-rust-src-path' or `RUST_SRC_PATH'"
;;     ;;               rust-src-path))


;;     (let ((default-directory (or (racer--cargo-project-root) default-directory))
;;           (process-environment (append (list
;;                                         (format "RUST_SRC_PATH=%s" rust-src-path)
;;                                         (format "CARGO_HOME=%s" cargo-home))
;;                                        process-environment)))
;;       (with-temp-message (format ">>>> %s ---  %s" default-directory process-environment))
;;       (-let [(exit-code stdout _stderr)
;;              (racer--shell-command racer-cmd (cons command args))]
;;         ;; Use `equal' instead of `zero' as exit-code can be a string
;;         ;; "Aborted" if racer crashes.
;;         (unless (equal 0 exit-code)
;;           (user-error "%s exited with %s. `M-x racer-debug' for more info"
;;                       racer-cmd exit-code))
;;         stdout)))
;;   )

(use-package rust-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

            (use-package flycheck-rust
              :ensure t

              :config (progn
                        (with-eval-after-load 'rust-mode
                          (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
                          ;;(add-hook 'flycheck-mode-hook #'flycheck-inline-mode)

                          ))
              )
           

            (add-hook 'rust-mode-hook #'racer-mode)
            (add-hook 'racer-mode-hook #'eldoc-mode)
            (add-hook 'rust-mode-hook 'cargo-minor-mode)
            (add-hook 'rust-mode-hook #'smartparens-mode)

            (add-hook 'rust-mode-hook
                      (lambda ()
                        (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)
                        ))

            ;;(defalias 'racer--call 'racer--call-override )

            (setq company-tooltip-align-annotations t)
            )
  )

(provide 'rust-mode-init)

;;; rust-mode-init.el ends here
