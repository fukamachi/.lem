(defpackage #:lem-my-init/modes/vi
  (:use #:cl
        #:lem
        #:lem-vi-mode
        #:lem/directory-mode))
(in-package #:lem-my-init/modes/vi)

(lem-vi-mode:vi-mode)

;; Requires this because number keys and symbol ones are swapped in my environment.
(define-key lem-vi-mode/core:*command-keymap* "M-!" 'lem/universal-argument:universal-argument-1)

;; XXX: directory-mode unexpectedly overrides these vi-mode's commands.
(define-key lem/directory-mode::*directory-mode-keymap* "n" 'lem-vi-mode/commands:vi-search-next)
(define-key lem/directory-mode::*directory-mode-keymap* "p" 'lem-vi-mode/commands:vi-search-previous)
