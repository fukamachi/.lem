(defpackage #:lem-my-init/modes/paredit
  (:use #:cl
        #:lem
        #:lem-paredit-mode
        #:lem-vi-mode))
(in-package #:lem-my-init/modes/paredit)

(define-key *paredit-mode-keymap* "M-l" 'paredit-slurp)
(define-key *paredit-mode-keymap* "M-h" 'paredit-barf)
(define-key *paredit-mode-keymap* "(" nil)
(define-key *paredit-mode-keymap* ")" nil)
(define-key *paredit-mode-keymap* "\"" nil)

(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'paredit-mode t))))

(define-command delete-next-sexp-on-paredit-mode () ()
  (if (find 'paredit-mode (buffer-minor-modes (current-buffer)))
      (kill-sexp)
      (lem-vi-mode/commands:vi-delete-line)))
(define-command change-next-sexp-on-paredit-mode () ()
  (if (find 'paredit-mode (buffer-minor-modes (current-buffer)))
      (progn
        (kill-sexp)
        (lem-vi-mode/core:change-state 'lem-vi-mode/core:insert))
      (lem-vi-mode/commands:vi-change-line)))

(defun %my-paredit-wrap-round (insert-at)
  (with-point ((p (current-point)))
    (unless (lem-vi-mode/commands::bolp p)
      (let ((c (character-at p -1)))
        (when (lem-base:syntax-closed-paren-char-p c)
          (lem-vi-mode/commands:vi-move-to-matching-paren))
        (cond
          ((or (lem-base:syntax-space-char-p c)
               (lem-base:syntax-open-paren-char-p c))
           nil)
          (t (lem-base:form-offset p -1)))))
    (move-point (current-point) p))
  (paredit-wrap-round)
  (lem-vi-mode/core:change-state 'lem-vi-mode/core:insert)
  (ecase insert-at
    (:before
     (lem-base:insert-character (current-point) #\Space)
     (backward-char))
    (:after
     (lem:forward-sexp))))

(define-command my-paredit-wrap-round () ()
  (%my-paredit-wrap-round :before))

(define-command my-paredit-wrap-round-after () ()
  (%my-paredit-wrap-round :after))

(define-command my-sexp-round-head-wrap-list () ()
  (lem:backward-up-list (current-point))
  (my-paredit-wrap-round))

(define-command my-sexp-round-tail-wrap-list () ()
  (lem:forward-up-list (current-point))
  (my-paredit-wrap-round-after))

(define-command my-sexp-move-to-prev-bracket () ()
  (lem:backward-up-list (current-point)))

(define-command my-sexp-move-to-next-bracket () ()
  (character-offset (current-point) (* -1 lem-vi-mode/commands::*cursor-offset*))
  (handler-case (progn
                  (lem:forward-up-list (current-point))
                  (character-offset (current-point) lem-vi-mode/commands::*cursor-offset*))
    (error ()
      (when (lem-vi-mode/commands::eolp (current-point))
        (lem-vi-mode/commands::goto-eol (current-point))))))

(define-key *command-keymap* "D" 'delete-next-sexp-on-paredit-mode)
(define-key *command-keymap* "C" 'change-next-sexp-on-paredit-mode)
(define-key *command-keymap* "Space @" 'paredit-splice)
(define-key *command-keymap* "Space w" 'my-paredit-wrap-round)
(define-key *command-keymap* "Space W" 'my-paredit-wrap-round-after)
(define-key *command-keymap* "Space i" 'my-sexp-round-head-wrap-list)
(define-key *command-keymap* "Space I" 'my-sexp-round-tail-wrap-list)
(define-key *command-keymap* "(" 'my-sexp-move-to-prev-bracket)
(define-key *command-keymap* ")" 'my-sexp-move-to-next-bracket)
(define-key *insert-keymap* "(" 'paredit-insert-paren)
(define-key *insert-keymap* ")" 'paredit-close-parenthesis)
(define-key *insert-keymap* "\"" 'paredit-insert-doublequote)
