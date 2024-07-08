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

;; Enable lem-vi-sexp mode for each lisp-mode buffer.
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

;; Delete the next element with 'D' instead of deleting to the end-of-line
;; to keep the parenthesis balanced.
(define-command delete-next-sexp-on-paredit-mode (&optional (n 1)) (:universal)
  (if (find 'vi-sexp (buffer-minor-modes (current-buffer)))
      (dotimes (i n)
        (kill-sexp))
      (call-command 'vi-delete-line n)))
(define-key *normal-keymap* "D" 'delete-next-sexp-on-paredit-mode)

;; Delete the next element with 'C' instead of deleting to the end-of-line
;; to keep the parenthesis balanced.
(define-command change-next-sexp-on-paredit-mode (&optional (n 1)) (:universal)
  (if (find 'vi-sexp (buffer-minor-modes (current-buffer)))
      (progn
        (dotimes (i n)
          (kill-sexp))
        (change-state 'insert))
      (call-command 'vi-change-line n)))
(define-key *normal-keymap* "C" 'change-next-sexp-on-paredit-mode)

;; M-x slime-qlot-exec
;; Establish a new SWANK connection in a project-local dist.
;; See https://github.com/fukamachi/qlot for the details.
;;
;; It also requires micros in the ./.qlot/local-projects directory.
;;   $ git clone https://github.com/lem-project/micros .qlot/local-projects
(define-command slime-qlot-exec () ()
  (let ((command (first (lem-lisp-mode/implementation::list-roswell-with-qlot-commands))))
    (when command
      (lem-lisp-mode:run-slime command))))
