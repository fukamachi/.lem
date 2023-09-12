(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode)
  (:import-from #:lem-vi-sexp
                #:vi-sexp-slurp
                #:vi-sexp-barf))
(in-package #:lem-my-init/modes/vi)

;; Enable vi-mode
(lem-vi-mode:vi-mode)

;; Keep 3 lines above and below the cursor
(setf (option-value "scrolloff") 3)

;; Requires this because number keys and symbol ones are swapped in my environment.
(define-key *normal-keymap* "M-!" 'lem/universal-argument:universal-argument-1)

;; Allow to slurp the next element with M-l,
;; and to barf the last element with M-h.
;; These are my favorite keybinds.
(define-key *normal-keymap* "M-l" 'vi-sexp-slurp)
(define-key *normal-keymap* "M-h" 'vi-sexp-barf)

(setf (variable-value 'leader-key :global) "Space")
