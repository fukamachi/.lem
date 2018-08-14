(defpackage #:lem-my-init
  (:use #:cl
        #:lem))
(in-package :lem-my-init)

(pushnew '("\\.json$" . lem-js-mode:js-mode) lem:*auto-mode-alist*)
(pushnew '("\\.jsx$" . lem-js-mode:js-mode) lem:*auto-mode-alist*)

(define-key *global-keymap* "Return" 'lem.language-mode:newline-and-indent)
(setf *scroll-recenter-p* nil)

(load #P"~/.lem/modes/10-vi.lisp")
(load #P"~/.lem/modes/10-paredit.lisp")
(load #P"~/.lem/modes/10-auto-save.lisp")
