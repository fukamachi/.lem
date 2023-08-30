(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode)
  (:import-from #:lem-paredit-mode
                #:paredit-slurp
                #:paredit-barf))
(in-package #:lem-my-init/modes/vi)

(lem-vi-mode:vi-mode)

;; Requires this because number keys and symbol ones are swapped in my environment.
(define-key lem-vi-mode:*normal-keymap* "M-!" 'lem/universal-argument:universal-argument-1)
(define-key lem-vi-mode:*normal-keymap* "M-l" 'paredit-slurp)
(define-key lem-vi-mode:*normal-keymap* "M-h" 'paredit-barf)
