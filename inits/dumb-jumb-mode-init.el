;;; dumb-jumb-mode-init.el ---




;;; Commentary:
;;

;;; Code:


;;; https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :ensure t
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window)
         )
  :config (progn
            (setq dumb-jump-selector 'ivy)
            ;; (setq dumb-jump-debug t)
            (setq dumb-jump-force-searcher 'ag)
            (setq dumb-jump-prefer-searcher 'ag)
            ;; (setq dumb-jump-selector 'helm)
            ))


;; (setq dumb-jump-default-project "~/code") to change default project if one is not found (defaults to ~)
;; (setq dumb-jump-quiet t) if Dumb Jump is too chatty.
;; To support more languages and/or definition types customize dumb-jump-find-rules variable.
;; (add-hook 'dumb-jump-after-jump-hook 'some-function) to execute code after you jump
;; (setq dumb-jump-selector 'ivy) to use ivy instead of the default popup for multiple options.
;; (setq dumb-jump-selector 'helm) to use helm instead of the default popup for multiple options.
;; (setq dumb-jump-force-searcher 'rg) to force the search program Dumb Jump should use.
;; It will always use this searcher. If not set (nil)
;; Dumb Jump will use git-grep if it's a git project and if not
;; will try searchers in the following order ag, rg, grep (first installed wins).
;; This is necessary if you want full control over the searcher Dumb Jump uses.
;; (setq dumb-jump-aggressive nil) to only automatically jump if there's only
;; one match and otherwise present you with a list. This defaults to t,
;; which means it will try its best to guess where you want to jump and only if it can't then give you a list of matches.
;; (setq dumb-jump-use-visible-window nil) if t (the default) when you're
;; using multiple windows/panes and the file to jump to is already
;; open in one of those windows then dumb jump will focus that
;; window and jump there instead of within your current window.
;; (setq dumb-jump-prefer-searcher 'rg) to let Dumb Jump know your searcher preference.
;; If set this will still use git-grep if it's a git project (because it's the fastest),
;; but will you use whatever you set here in any other situation.
;; If not set Dumb Jump will follow the same order as mentioned in the dumb-jump-force-searcher description.
;; At this time setting this value is only necessary if you prefer rg but have ag installed too.


(with-eval-after-load 'hydra
  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))
  )


(provide 'dumb-jumb-mode-init)

;;; dumb-jumb-mode-init.el ends here
