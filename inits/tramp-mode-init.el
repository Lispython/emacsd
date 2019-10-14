;;; tramp-mode-init.el ---

;;; Commentary:
;;

;;; Code:

(use-package tramp
  :init (setq tramp-default-method "ssh")
  :config (progn
            (with-eval-after-load 'tramp
              (add-to-list 'tramp-methods
                           '("sshx11"
                             (tramp-login-program        "ssh")
                             (tramp-login-args           (("-l" "%u") ("-p" "%p") ("%c")
                                                          ("-e" "none") ("-X") ("%h")))
                             (tramp-async-args           (("-q")))
                             (tramp-remote-shell         "/bin/sh")
                             (tramp-remote-shell-login   ("-l"))
                             (tramp-remote-shell-args    ("-c"))
                             (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
                                                          ("-o" "UserKnownHostsFile=/dev/null")
                                                          ("-o" "StrictHostKeyChecking=no")
                                                          ("-o" "ForwardX11=yes")))
                             (tramp-default-port         22)))
              (tramp-set-completion-function "sshx11" tramp-completion-function-alist-ssh))
            )

  )

(use-package vagrant-tramp)

(use-package ssh-tunnels

  :config (progn

            ;; (setq ssh-tunnels-configurations
            ;;       '((:name "cron01.stage clickhouse"
            ;;                :local-port 8123
            ;;                :remote-port 8123
            ;;                :host "1chouse001.prod.crm.rambler.tech"
            ;;                :login "a.sokolovskiy@cron01.stage.crm.rambler.tech")
            ;;         ))
            (setq ssh-tunnels-name-width 30)

            )
  )




(provide 'tramp-mode-init)

;;; tramp-mode-init.el ends here
