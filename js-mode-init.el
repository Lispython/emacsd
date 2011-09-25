(require 'flymake)

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



(add-hook 'javascript-mode-hook (lambda ()
								  (flymake-mode t)))

(add-hook 'espresso-mode-hook (lambda ()
								(flymake-mode t)))

(add-hook 'js2-mode-hook (lambda ()
						   (slime-js-minor-mode t)))

(global-set-key [f5] 'slime-js-reload)

(provide 'js-mode-init)
