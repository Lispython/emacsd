

(defconst rst-output-buffer-name "*rst-output*"
  "Name of temporary buffer for rst command output.")


(defun rst-make-markup (&optional output-buffer-name)
  "Run `markdown' on current buffer and insert output in buffer BUFFER-OUTPUT."
  (interactive)
  (let ((title (buffer-name))
        (begin-region)
        (end-region))
    (if (and (boundp 'transient-mark-mode) transient-mark-mode mark-active)
        (setq begin-region (region-beginning)
              end-region (region-end))
      (setq begin-region (point-min)
            end-region (point-max)))

    (unless output-buffer-name
      (setq output-buffer-name rst-output-buffer-name))

;    (if markdown-command-needs-filename
        ;; Handle case when `markdown-command' does not read from stdin
        (if (not buffer-file-name)
            (error "Must be visiting a file")
          (shell-command (concat rst-compile " " buffer-file-name)
                         output-buffer-name))
      ;; Pass region to `rst-command' via stdin
      (shell-command-on-region begin-region end-region rst-compile
                               output-buffer-name)
;)

    ;; Add header and footer and switch to html-mode.
    (save-current-buffer
      (set-buffer output-buffer-name)
      (goto-char (point-min))
;;      (unless (markdown-output-standalone-p)
;;        (markdown-add-xhtml-header-and-footer title))
      (html-mode))

    ;; Ensure buffer gets raised, even with short command output
    (switch-to-buffer-other-window output-buffer-name)))


(defun rst-preview ()
  "Run `rst' on the current buffer and preview the output in a browser."
  (interactive)
  (rst-make-markup rst-output-buffer-name)
  (browse-url-of-buffer rst-output-buffer-name))

