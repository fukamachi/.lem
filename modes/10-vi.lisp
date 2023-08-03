(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode))
(in-package #:lem-my-init/modes/vi)

(lem-vi-mode:vi-mode)

;; Requires this because number keys and symbol ones are swapped in my environment.
(define-key lem-vi-mode/core:*command-keymap* "M-!" 'lem/universal-argument:universal-argument-1)
