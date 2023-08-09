(defpackage #:lem-my-init/modes/lisp-mode
  (:use #:cl
        #:lem
        #:lem-lisp-mode))
(in-package #:lem-my-init/modes/lisp-mode)

(define-command lisp-quickload-file () ()
  (lem-lisp-mode::check-connection)
  (let ((package (lem-lisp-mode::buffer-package (current-buffer))))
    (when package
      (lem-lisp-mode::eval-with-transcript
       `(ql:quickload ,(string-downcase package))))))
(define-key *global-keymap* "C-c C-q" 'lisp-quickload-file)

;; For REPL mode, change the vi-mode to INSERT on startup.
(lem:add-hook lem-lisp-mode:*lisp-repl-mode-hook*
              (lambda ()
                (lem-vi-mode/core:change-state 'lem-vi-mode/core:insert)))

;; For SLDB mode, change the vi-mode to NORMAL.
(lem:add-hook lem-lisp-mode:*lisp-sldb-mode-hook*
              (lambda ()
                (lem-vi-mode/core:change-state 'lem-vi-mode/core:normal)))
