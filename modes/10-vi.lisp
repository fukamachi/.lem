(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode))
(in-package #:lem-my-init/modes/vi)

(lem-vi-mode:vi-mode)

(define-key *minibuf-keymap* "C-w" 'lem-vi-mode.commands:vi-kill-last-word)
