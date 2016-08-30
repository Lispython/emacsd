(add-hook 'sgml-mode-hook
	  (lambda ()
	    ;; Default indentation to 2, but let SGML mode guess, too.
	    (set (make-local-variable 'sgml-basic-offset) 2)
	    (sgml-guess-indent)))
