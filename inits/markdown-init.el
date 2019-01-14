;;; markdown-init.el ---


;;; Commentary:
;;

;;; Code:

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "docker run -i --rm emacsd pandoc --from markdown_github -t html5 --mathjax --highlight-style pygments --standalone"))

  ;;:init (setq markdown-command "docker run --rm -i emacsd markdown"))

(message "markdown init loaded")

(provide 'markdown-init)

;;; markdown-init.el ends here
