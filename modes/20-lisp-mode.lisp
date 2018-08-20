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
