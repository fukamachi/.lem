(defpackage #:lem-my-init/modes/paredit
  (:use #:cl
        #:lem
        #:lem-paredit-mode
        #:lem-vi-mode))
(in-package #:lem-my-init/modes/paredit)

(define-key *paredit-mode-keymap* "M-l" 'paredit-slurp)
(define-key *paredit-mode-keymap* "M-h" 'paredit-barf)

(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'paredit-mode t))))

(define-command delete-next-sexp-on-paredit-mode () ()
  (if (find 'paredit-mode (buffer-minor-modes (current-buffer)))
      (kill-sexp)
      (lem-vi-mode.commands:vi-delete-line)))
(define-command change-next-sexp-on-paredit-mode () ()
  (if (find 'paredit-mode (buffer-minor-modes (current-buffer)))
      (progn
        (kill-sexp)
        (lem-vi-mode.core:change-state 'lem-vi-mode.core:insert))
      (lem-vi-mode.commands:vi-clear-line)))
(define-key *command-keymap* "D" 'delete-next-sexp-on-paredit-mode)
(define-key *command-keymap* "C" 'change-next-sexp-on-paredit-mode)
