;; This django-html-mode is mainly derived from html mode
(require 'sgml-mode)
 
(defvar django-html-mode-hook nil)
 
(defvar django-html-mode-map
  (let ((django-html-mode-map (make-keymap)))
    (define-key django-html-mode-map "\C-j" 'newline-and-indent)
    django-html-mode-map)
  "Keymap for Django major mode")
  
;; start and end keyword for block/comment/variable
(defconst django-html-open-block     "{%")
(defconst django-html-close-block    "%}")
(defconst jinja-html-open-block      "{%-")
(defconst jinja-html-close-block     "-%}")
(defconst django-html-open-variable  "{{")
(defconst django-html-close-variable "}}")
 
(defconst jinja-comments
  `(
    (,(rx (eval "{#")
	  (*? (or anything eol line-start))
	  (eval "#}"))
     . font-lock-comment-face)))
 
(defconst django-html-font-lock-keywords-1
  (append
   jinja-comments
   sgml-font-lock-keywords-1)
  "First level keyword highlighting")
 
(defconst django-html-font-lock-keywords-2
  (append
   django-html-font-lock-keywords-1
   sgml-font-lock-keywords-2))
 
(defconst django-html-font-lock-keywords-3
  (append
   django-html-font-lock-keywords-1
   django-html-font-lock-keywords-2
 
   `(
     
     ;; variable font lock
     (,(rx (eval django-html-open-variable)
           (1+ space)
           (group (0+ (not (any "}"))))
           (1+ space)
           (eval django-html-close-variable))
      (1 font-lock-variable-name-face))
     
     ;; start, end keyword font lock
     (,(rx (group (or 
                   (eval jinja-html-open-block)
                   (eval jinja-html-close-block)
                   (eval django-html-open-block)
                   (eval django-html-close-block)
                   (eval django-html-open-variable)
                   (eval django-html-close-variable))))
      (1 font-lock-builtin-face))
 
     ;; end prefix keyword font lock
     (,(rx (or (eval django-html-open-block)
               (eval jinja-html-open-block))
           (1+ space)
           (group (and "end"
                       ;; end prefix keywords
                       (or "if" "for" "ifequal" "block" "ifnotequal" "spaceless" "filter")))
           (1+ space)
           (or (eval django-html-close-block)
               (eval jinja-html-close-block)))
      
      (1 font-lock-keyword-face)) 
     
     ;; more words after keyword
     (,(rx (or (eval django-html-open-block)
               (eval jinja-html-open-block))
           (1+ space)
           (group (or "extends" "for" "cycle" "filter" "else" "set"
                      "firstof" "debug" "if" "ifchanged" "ifequal" "ifnotequal"
                      "include" "load" "now" "regroup" "spaceless" "ssi"
                      "templatetag" "widthratio" "block" "set" "macro"))
           (0+ space)
           (group (0+ "not"))
           (*? anything)
           
           (or (eval django-html-close-block)
               (eval jinja-html-close-block)))
     
      (1 font-lock-keyword-face)
      (2 font-lock-variable-name-face))
 
     ;; TODO: if specific cases for supporting "or", "not", and "and"
 
     ;; for sepcific cases for supporting in
     (,(rx (or (eval django-html-open-block)
               (eval jinja-html-open-block))
 
           (1+ space)
           (or "for" "if")
           (1+ space)
 
           (group (1+ (or word ?_ ?.)))
 
           (1+ space)
           (group "in")
           (1+ space)
           
           (group (1+ (or word ?_ ?.)))
 
           (group (? (1+ space) "reverse"))
 
           (1+ space)
 
           (or (eval django-html-close-block)
               (eval jinja-html-close-block)))
     
      (1 font-lock-variable-name-face) (2 font-lock-keyword-face)
      (3 font-lock-variable-name-face) (4 font-lock-keyword-face))
     
     )))
       
(defvar django-html-font-lock-keywords
  django-html-font-lock-keywords-1)
 
(defvar django-html-mode-syntax-table
  (let ((django-html-mode-syntax-table (make-syntax-table)))
    django-html-mode-syntax-table)
  "Syntax table for django-html-mode")
 
;;;###autoload
(define-derived-mode django-html-mode html-mode  "django-html"
  "Major mode for editing django html files(.djhtml)"
  :group 'django-html
  
  ;; it mainly from sgml-mode font lock setting
  (set (make-local-variable 'font-lock-defaults)
       '((django-html-font-lock-keywords
          django-html-font-lock-keywords-1
          django-html-font-lock-keywords-2
          django-html-font-lock-keywords-3)
         nil t nil nil
         (font-lock-syntactic-keywords
          . sgml-font-lock-syntactic-keywords))))
 
(provide 'django-html-mode)