(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode)
  (:import-from #:lem-paredit-mode
                #:paredit-slurp
                #:paredit-barf))
(in-package #:lem-my-init/modes/vi)

;; Enable vi-mode
(lem-vi-mode:vi-mode)

;; Requires this because number keys and symbol ones are swapped in my environment.
(define-key lem-vi-mode:*normal-keymap* "M-!" 'lem/universal-argument:universal-argument-1)

;; Allow to slurp the next element with M-l,
;; and to barf the last element with M-h.
;; These are my favorite keybinds.
(define-key lem-vi-mode:*normal-keymap* "M-l" 'paredit-slurp)
(define-key lem-vi-mode:*normal-keymap* "M-h" 'paredit-barf)
