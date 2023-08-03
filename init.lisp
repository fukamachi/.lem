(defpackage #:lem-my-init
  (:use #:cl
        #:lem))
(in-package :lem-my-init)

;(define-key *global-keymap* "Return" 'lem.language-mode:newline-and-indent)
(setf *scroll-recenter-p* nil)

(let ((asdf:*central-registry* (cons #P"~/.lem/" asdf:*central-registry*)))
  (ql:quickload :lem-my-init))

(define-command slime-qlot-exec (directory) ((list (prompt-for-directory "Project directory: " (buffer-directory))))
  (change-directory directory)
  (lem-lisp-mode:run-slime (lem-lisp-mode::get-lisp-command :prefix "qlot exec ")))
