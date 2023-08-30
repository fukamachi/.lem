(defpackage #:lem-my-init/modes/lisp-mode
  (:use #:cl
        #:lem
        #:lem-lisp-mode)
  (:import-from #:lem-vi-mode
                #:change-state
                #:normal
                #:insert
                #:*normal-keymap*)
  (:import-from #:lem-vi-mode/commands
                #:vi-delete-line
                #:vi-change-line)
  (:import-from #:lem-vi-sexp
                #:vi-sexp)
  (:import-from #:lem-paredit-mode
                #:kill-sexp))
(in-package #:lem-my-init/modes/lisp-mode)

(define-command lisp-quickload-file () ()
  (lem-lisp-mode::check-connection)
  (let ((package (lem-lisp-mode::buffer-package (current-buffer))))
    (when package
      (lem-lisp-mode::eval-with-transcript
       `(ql:quickload ,(string-downcase package))))))
(define-key *global-keymap* "C-c C-q" 'lisp-quickload-file)

(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lisp-mode)
                  (change-buffer-mode buffer 'vi-sexp t))))

;; For REPL mode, change the vi-mode to INSERT on startup.
(lem:add-hook lem-lisp-mode:*lisp-repl-mode-hook*
              (lambda ()
                (change-state 'insert)))

;; For SLDB mode, change the vi-mode to NORMAL.
(lem:add-hook lem-lisp-mode:*lisp-sldb-mode-hook*
              (lambda ()
                (change-state 'normal)))

(define-command delete-next-sexp-on-paredit-mode (&optional (n 1)) ("p")
  (if (find 'vi-sexp (buffer-minor-modes (current-buffer)))
      (dotimes (i n)
        (kill-sexp))
      (call-command 'vi-delete-line n)))

(define-command change-next-sexp-on-paredit-mode (&optional (n 1)) ("p")
  (if (find 'vi-sexp (buffer-minor-modes (current-buffer)))
      (progn
        (dotimes (i n)
          (kill-sexp))
        (change-state 'insert))
      (call-command 'vi-change-line n)))

(define-key *normal-keymap* "D" 'delete-next-sexp-on-paredit-mode)
(define-key *normal-keymap* "C" 'change-next-sexp-on-paredit-mode)
