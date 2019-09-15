;;; clang-init.el ---

;; (require 'cedet-global)

;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode)

;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (semantic-mode t)
;;             (message "clang mode hook")
;;             (require 'ecb)
;;             (require 'semantic/ia)
;;             (require 'semantic/bovine/gcc)
;;             (global-ede-mode t)
;;             ))


;; (add-hook 'semantic-init-hooks
;;           (lambda ()
;;             (message "semantic init hooks")
;;             (imenu-add-to-menubar "TAGS")))

;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))


;; ;; Add autocomplete
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-gtags)
;;             (add-to-list 'ac-sources 'ac-source-semantic)
;;             ))


;;; Commentary:
;;

;;; Code:

(use-package irony

  :config (progn
            (add-hook 'c++-mode-hook 'irony-mode)
            (add-hook 'c-mode-hook 'irony-mode)
            (add-hook 'objc-mode-hook 'irony-mode)
            (setq irony--server-executable (format "/usr/local/bin/docker run -i -v /Users/Alexandr/github/experiments/redis/:/Users/Alexandr/github/experiments/redis/ -v %s:%s emacsd /usr/bin/irony-server" temporary-file-directory temporary-file-directory))

            ))


;(eval-after-load 'flycheck
;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(with-eval-after-load 'irony
  (defun irony--start-server-process ()
    (unless irony--server-executable
      ;; if not found, an `irony-server-error' error is signaled
      (setq irony--server-executable (irony--find-server-executable)))


    (let ((process-connection-type nil)
          (process-adaptive-read-buffering nil)
          (w32-pipe-buffer-size (when (boundp 'w32-pipe-buffer-size)
                                  (or irony-server-w32-pipe-buffer-size
                                      w32-pipe-buffer-size)))
          process)
      (setq process
            (start-process-shell-command
             "Irony"                    ;process name
             irony--server-buffer       ;buffer
             (format ;;"%s -i 2 > %s"      ;command
              "%s -i 2 > %s"
                     irony--server-executable
                     ;;(shell-quote-argument irony--server-executable)
                     (expand-file-name
                      (format-time-string "irony.%Y-%m-%d_%Hh-%Mm-%Ss.log")
                      temporary-file-directory))))
      ;; (with-temp-message (format "irony--start-server-process %s" (process-command process)))
      (set-process-query-on-exit-flag process nil)
      (irony-iotask-setup-process process)
      process))
  )

(use-package irony-eldoc
  :config (progn
            (add-hook 'irony-mode-hook #'irony-eldoc)
            ))


(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-irony)
  (add-to-list 'company-backends 'company-c-headers))

;; (use-package function-args
;;   :config
;;   (fa-config-default)
;;   )

(use-package company-irony-c-headers

  :config (progn
            ;; Load with `irony-mode` as a grouped backend
            (eval-after-load 'company
              '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))))


(with-eval-after-load 'gdb
  (setq
   ;; use gdb-many-windows by default
   gdb-many-windows t

   ;; Non-nil means display source file containing the main routine at startup
   gdb-show-main t
   ))


(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(provide 'clang-init)

;;; clang-init.el ends here
