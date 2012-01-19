;; (defun flymake-jslint-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		     'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;; 		      temp-file
;; 		      (file-name-directory buffer-file-name))))
;;     (list "rhino" (list (expand-file-name "~/.emacs.d/jslint/jslint.js") local-file))))

;; (setq flymake-allowed-file-name-masks
;;       (cons '(".+\\.js$"
;; 	      flymake-jslint-init
;; 	      flymake-simple-cleanup
;; 	      flymake-get-real-file-name)
;; 	    flymake-allowed-file-name-masks))

;; (setq flymake-err-line-patterns
;;       (cons '("^Lint at line \\([[:digit:]]+\\) character \\([[:digit:]]+\\): \\(.+\\)$"
;; 	      nil 1 2 3)
;; 	    flymake-err-line-patterns))


;; (when (load "flymake" t)
;;   (defun flymake-jslint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 		       'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "/home/alex/local/node/bin/jslint" (list local-file))))

;;   (setq flymake-err-line-patterns
;; 	(cons '("^  [[:digit:]]+ \\([[:digit:]]+\\),\\([[:digit:]]+\\): \\(.+\\)$"
;; 		nil 1 2 3)
;; 	      flymake-err-line-patterns))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.js\\'" flymake-jslint-init)))


;; adapted from http://www.emacswiki.org/emacs/FlymakeJavaScript
;;
;; Installation:
;;
;;     (add-to-list 'load-path "~/lib/jshint-mode")
;;     (require 'flymake-jshint)
;;     (add-hook 'javascript-mode-hook
;;         (lambda () (flymake-mode t)))
;;
;; run M-x flymake-mode to turn flymake on and off
;;

(require 'flymake)

(defcustom jshint-mode-mode "jshint"
  "Can use either jshint or jslint"
  :type 'string
  :group 'flymake-jshint)

(defcustom jshint-mode-node-program "node"
  "The program name to invoke node.js."
  :type 'string
  :group 'flymake-jshint)

(defcustom jshint-mode-location (file-name-directory load-file-name)
  "The directory jshint-mode.js may be found in."
  :type 'string
  :group 'flymake-jshint)

(defcustom jshint-mode-port 3003
  "The port the jshint-mode server runs on."
  :type 'integer
  :group 'flymake-jshint)

(defcustom jshint-mode-host "127.0.0.1"
  "The host the jshint-mode server runs on."
  :type 'string
  :group 'flymake-jshint)

(setq jshint-process "jshint-mode-server")
(setq jshint-buffer "*jshint-mode*")

(defun jshint-mode-init ()
  "Start the jshint-mode server."
  (interactive)
  (if (eq (process-status jshint-process) 'run)
      'started
    (start-process
     jshint-process
     jshint-buffer
     jshint-mode-node-program
     (expand-file-name (concat jshint-mode-location "/jshint-mode.js"))
     "--host" jshint-mode-host
     "--port" (number-to-string jshint-mode-port))
    (set-process-query-on-exit-flag (get-process jshint-process) nil)
    (message
     (concat "jshint server has started on " jshint-mode-host
             (number-to-string jshint-mode-port)))
    'starting
    ))

(defun jshint-mode-stop ()
  "Stop the jshint-mode server."
  (interactive)
  (delete-process jshint-process))

(defun flymake-jshint-init ()
  (if (eq (jshint-mode-init) 'started)
      (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
             (local-file (file-relative-name temp-file
                                             (file-name-directory buffer-file-name)))
             (jshint-url (format "http://%s:%d/check" jshint-mode-host jshint-mode-port)))
        (list "curl" (list "--form" (format "source=<%s" local-file)
                           "--form" (format "filename=%s" local-file)
                           "--form" (format "mode=%s" jshint-mode-mode)
                           jshint-url)))))

(setq flymake-allowed-file-name-masks
      (cons '(".+\\.js$"
	      flymake-jshint-init
	      flymake-simple-cleanup
	      flymake-get-real-file-name)
	    flymake-allowed-file-name-masks))

(setq flymake-err-line-patterns
      (cons '("^Lint at line \\([[:digit:]]+\\) character \\([[:digit:]]+\\): \\(.+\\)$"
	      nil 1 2 3)
	    flymake-err-line-patterns))



(add-hook 'javascript-mode-hook (lambda ()
								  (flymake-mode t)))

(add-hook 'espresso-mode-hook (lambda ()
								(flymake-mode t)))

(add-hook 'js2-mode-hook (lambda ()
						   (slime-js-minor-mode t)))

(global-set-key [f5] 'slime-js-reload)

(provide 'js-mode-init)
