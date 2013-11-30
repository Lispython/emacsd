

(defconst *org-root* "~/Dropbox/.org/"
  "Own org directory")

(add-to-list 'load-path (concat **emacs-ext-dir** "org-mode/lisp"))
(add-to-list 'load-path (concat **emacs-ext-dir** "org-mode/contrib/lisp"))
;;; Remember mode
(add-to-list 'load-path (concat **emacs-ext-dir** "org-mode/remember"))

(require 'remember)
(require 'org-remember)

(require 'org-install)
(require 'ob-tangle)

(setq org-directory *org-root*)
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull (concat org-mobile-directory "flagged.org"))
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq *org-work* (concat org-directory "work.org"))
(setq *org-personal* (concat org-directory "personal.org"))
(setq *org-projects* (concat org-directory "projects.org"))

(setq org-agenda-files
      (list
       (concat *org-root* "main.org")
       (concat *org-root* "work.org")
       (concat *org-root* "projects.org")
       (concat *org-root* "personal.org")))


(setq org-startup-indented t)
(org-remember-insinuate)

;;logging

(setq org-log-done 'time)
(setq org-log-into-drawer nil)
(setq org-log-redeadline'note)
(setq org-log-reschedule 'time)
(setq org-agenda-include-diary t)


(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; KEYBINDINGS
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c C-a") 'org-show-all)
(define-key global-map (kbd "C-c r") 'org-remember)

(setq org-default-notes-file (concat org-directory "/notes.org"))


(global-font-lock-mode 1)

(setq org-todo-keywords '((type "TODO" "NEXT" "WAITING" "STARTED" "|" "DONE" "CANCELED")))

;; color-code task types.

(setf org-todo-keyword-faces '(("NEXT" . (:foreground "yellow" :background "red" :bold t :weight bold))
			       ("TODO" . (:foreground "cyan" :background "steelblue" :bold t :weight bold))
			       ("WAITING" . (:foreground "yellow" :background "magenta2" :bold t :weight bold))
			       ("DONE" . (:foreground "green" :background "base03"))))

;;HOOKS
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(add-hook 'org-mode-hook
	  (lambda ()
	    (message "org mode hook")
	    (set-face-font 'default "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
	    (set-default-font "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

	    ;; yasnippet (allow yasnippet to do it's thing in org files)
	    (make-variable-buffer-local 'yas/trigger-key)
	    (setq yas/trigger-key [tab])
	    (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
	    (define-key yas/keymap [tab] 'yas/next-field)))

(setq org-remember-templates
      '(
	("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" (concat org-directory "newgtd.org") "Tasks")
	("Journal" ?j "\n* %^{topic} %T \n%i%?\n" (concat org-directory  "journal.org"))
	("Daily Review" ?a "** %t :COACH: \n%[~/Dropbox/.org/templates/.daily_review.tmpl]\n"
	 (concat org-directory "journal.org"))
	("Idea" ?i "* %^{Title}\n %i\n %a" (concat org-directory "journal.org") "New Ideas")
	("Bug" ?b "* BUG %?\n %i\n %a" (concat org-directory "bugs.org") "Bugs")
        ))

;;(add-hook 'text-mode-hook 'turn-on-orgtbl)



;; active Babel languages

(setq org-confirm-babel-evaluate nil)

;; (setq org-babel-load-languages
;;       '((emacs-lisp . t)
;; 	(R . t)
;; 	(C  .t)
;; 	(sh . t)
;; 	(python . t)
;; 	(awk . t)
;; 	(css . t)
;; 	(lisp . t)
;; 	(org . t)
;; 	(sql . t)))


(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (R . t)
   (C . t)
   (awk . t)
   (css . t)
   (perl . t)
   (ruby . t)
   (python . t)
   (js . t)
   (haskell . t)
   (clojure . t)
   (lisp . t)
   (org . t)
   (sql . t)))


;; CUSOM HELP FUNCTIONS

(defun org-my ()
  (interactive)
  (find-file "~/Dropbox/.org/gtd.org")
)

(defun work-org ()
  (interactive)
  (find-file (concat **org-root** "work.org")))

(defun main-org ()
  (interactive)
  (find-file (concat **org-root** "main.org")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/.org/gtd.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	("j" "Journal" entry (file+datetree "~/Dropbox/.org/journal.org")
	 "* %?\nEntered on %U\n %i\n %a")))

(message "org-mode init loaded")














