;;; package --- Summary


;;; Summary

;;; Commentary:

;;; Code:


(defconst **pylookup-dir** "~/.emacs.d/pylookup/")

;;(add-to-list 'load-path pylookup-dir)


(defsubst string-join (strings &optional separator)
  "Join all STRINGS using SEPARATOR."
  (mapconcat 'identity strings separator))



(defun pylookup-exec-lookup-override (search-term)
  "Run a pylookup with SEARCH-TERM process and return a list of (term, url) pairs."
  (let* ((parts (split-string pylookup-program))
        (program (car parts))
        (args (append (cdr parts) (list
                                    "-d" (expand-file-name pylookup-db-file)
                                    "-l" search-term
                                    "-f" "Emacs"))))
    (with-temp-message (format "Running pylookup-exec-lookup parsed program: %s" program))
    (with-temp-message (format "Running pylookup-exec-lookup parsed args: %s" args))

    (mapcar*
     (lambda (x) (split-string x ";"))
     (split-string
      (with-output-to-string
        (apply #'call-process program nil standard-output nil args))
      "\n" t))))


(defun pylookup-exec-get-cache-override ()
  "Run a pylookup process and get a list of cache (db key)"
  (with-temp-message "pylookup-exec-get-cache-override")

    (let* ((parts (split-string pylookup-program))
        (program (car parts))
        (args (append (cdr parts) (list
                                    "-d" (expand-file-name pylookup-db-file)
                                    "-c"))))
    (with-temp-message (format "Running pylookup-exec-get-cache-override parsed program: %s" program))
    (with-temp-message (format "Running  pylookup-exec-get-cache-override parsed args: %s" args))
    (split-string
     (with-output-to-string
       (apply #'call-process program nil standard-output nil args))))
    )



(use-package pylookup
  :load-path (**pylookup-dir**)
  :bind (("C-c l" . pylookup-lookup))
  :init (progn (message "Use package pylookup init")

               (setq pylookup-program
                     (string-join
                      (list **docker-run-base**
                            (format "--volume=%s:%s" (file-truename **pylookup-dir**) "/pylookup")
                            docker-container-name
                            "/pylookup/pylookup.py"
                            ) " "))

               ;;(setq pylookup-exec-lookup 'pylookup-exec-lookup-custom)
               (with-temp-message (format "Pylookup program %s" pylookup-program))
               ;;(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
               (setq pylookup-db-file "/pylookup/pylookup.db")
               )
  :config (progn (message "Use package pylookup config")

               (defalias 'pylookup-exec-lookup 'pylookup-exec-lookup-override)
               (defalias 'pylookup-exec-get-cache 'pylookup-exec-get-cache-override)
               (autoload 'pylookup-lookup "pylookup"
                 "Lookup SEARCH-TERM in the Python HTML indexes." t)

               (autoload 'pylookup-update "pylookup"
                 "Run pylookup-update and create the database at `pylookup-db-file'." t)
           )
  ;;:mode ("\\.txt$" . rst-mode)
  )



(provide 'pylookup-init)
;;; pylookup-init.el ends here
