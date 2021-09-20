;;; emacs-osx.el ---
;;; Code:

(setq debug-on-error t)

(defconst **emacs-dir** "~/.emacs.d/"
  "Top level emacs directory")

(defconst **emacs-ext-dir** (concat **emacs-dir** "ext/")
  "Directory that store third party modes/etc/")

(defconst **docker-run** "docker run --rm -i emacsd")

(defconst **docker-run-base** "/usr/local/bin/docker run -i --rm")


(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))

;; Don't clutter up directories with files~
(setq backup-directory-alist (list (cons ".*" backup-dir)))

;; Don't clutter with #files either

(setq auto-save-list-file-prefix autosave-dir)
;;; Commentary:
;;

(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)


(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ;; You might already have this line


(defun with-emacs.d (&rest args)
  (mapconcat 'identity (append (list (file-truename **emacs-dir**)) args) ""))



;;(set-default-font "Consolas-8") ;;default font
;;the following is size 7 for me...

;;(set-face-font 'default "-unknown-Envy Code R-normal-normal-normal-*-13-*-*-1*-m-0-iso10646-1")
;;(set-face-font 'default "-outline-Bitstream Vera Sans Mono-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")
;;(set-face-font 'default "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;;(set-frame-font "Envy Code R-7") ;; doesn't work consistently ;

;; Font family
;;(set-frame-font "-unknown-Anonymous Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")


;;; Remote file editing via ssh
(add-to-list 'load-path "~/.emacs.d/tramp-files/lisp")


;;AUTO COMPLETE
(add-to-list 'load-path "~/.emacs.d/ext")

;;; Copy-paste of list extensions
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/inits/")


(load-file "~/.emacs.d/nxml-mode/rng-auto.el")


;;GLOBAL REQUIREMENTS
(require 'font-lock)

(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))


;;SET VARIABLES OF EMACS
(menu-bar-mode nil) ;this too
(tool-bar-mode nil) ;hide tool bar too
(tool-bar-mode -1)

(scroll-bar-mode nil) ;hide scrroll bar
(scroll-bar-mode -1)

;; Turn on column number mode
(column-number-mode t) ;; but this one is good
;;(ido-mode t)
;;(setq flymake-start-syntax-check-on-find-file nil)

;; Don't disable
(show-paren-mode t) ;;hightlight brackets
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-splash-screen t) ;;;do't show splash screen
;;(setq default-tab-width 4)
(setq tab-with 4)
(setq-default indent-tabs-mode nil)
(desktop-save-mode t)
(modify-coding-system-alist 'file ".*" 'utf-8) ;; fuck cp1251 and koi-8


(load "ui-init.el")

;;(add-to-list 'custom-theme-load-path **themes-dir**)



; Makes clipboard work
(setq select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;;for emacs 2.4
(setq interprogram-paste-function 'x-selection-value)
(delete-selection-mode t) ;; Delete selected by Ctrl-D
(transient-mark-mode t) ;;hightlight by C-Space
;; enable horizontal scrolling
;;(hscroll-global-mode t)

(defun add-subdirs-to-load-path (path)
  "Add subdirectories "

  (let ((default-directory path))
    (normal-top-level-add-subdirs-to-load-path))
  )

(add-subdirs-to-load-path **emacs-ext-dir**)
(add-subdirs-to-load-path "~/.emacs.d/lisp/")

;;;(color-theme-tango)

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome")

(setq browse-url-browser-function 'browse-url-default-windows-browser)
(setq browse-url-browser-function 'browse-url-default-macosx-browser)


(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  )

(load "common-init.el")
(load "dired-init.el")

(load "env-init.el")

(load "lisp-init.el")
(load "ibuffer-mode-init.el")

(load "virtualenv-init.el")
(load "outline-mode-init.el")
;;(load "python-mode-init.el")
(load "python-mode-dockerized-init.el")

(load "org-mode-init.el")
(load "js-mode-init.el")
(load "css-mode-init.el")
(load "sudo-save.el")
(load "org-readme.el")
(load "bash-completion-init.el")
(load "tramp-mode-init.el")
(load "yaml-mode-init.el")
(load "sgml-mode-init.el")
(load "autopep8-init.el")
(load "flycheck-init.el")
(load "crontab-init.el")
;(load "ac-emoji.el")
(load "markdown-init.el")
(load "highlight-symbol-init.el")
(load "debug-init.el")

;; (load "slime-init.el")


;;; Python configuration
(load "pylookup-init.el")


(load "yasnippet-init.el")

(load "editorconfig-init.el")

(load "multiple-cursors-init.el")

(load "magit-init.el")

(load "docker-init.el")

(load "company-mode-init.el")

(load "go-mode-init.el")

(load "http-init.el")

(load "toml-mode-init.el")

(load "rust-mode-init.el")

(load "clang-init.el")
(load "elixir-init.el")
(load "erlang-init.el")
(load "swift-init.el")
(load "scala-init.el")
(load "saltstack-init.el")
(load "dart-mode-init.el")

;; TODO: add more languages
;;; Default goto
(load "dumb-jumb-mode-init.el")

(load "projectile-mode-init.el")

(load "web-mode-init.el")

(load "prog-mode-init.el")

(load "dap-mode-init.el")


;;(load "recompiler")



(defun autocompile ()
  "Compile itself if this is config file"
  (interactive)
  (if (or
       (string-match ".emacs.d/[a-zA-z_\+\-]*.el$" (buffer-file-name))
       (string-match ".emacs.d/tramp/[a-zA-z_\+\-]*.el$" (buffer-file-name))
       (string-match ".emacs.d/themes/[a-zA-z_\+\-]*.el$" (buffer-file-name))
       )
      (byte-compile-file (buffer-file-name))))

;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;;; HOOKS FOR MODES




(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook 'autocompile)


(provide 'emacs-osx)

;;; emacs-osx.el ends here
