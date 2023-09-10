(defpackage #:lem-my-init
  (:use #:cl
        #:lem)
  (:import-from #:lem/frame-multiplexer
                #:frame-multiplexer))
(in-package :lem-my-init)

;; Disable Lem's auto recenter
(setf *scroll-recenter-p* nil)

;; Dumped image contains the cached source registry
;; Ensure to reinitialize it to let ASDF find new systems.
(asdf:clear-source-registry)

;; Load my init files.
(let ((asdf:*central-registry* (cons #P"~/.lem/" asdf:*central-registry*)))
  (ql:quickload :lem-my-init))

;; Disable frame-multiplexer, which shows a switcher at the top of the window.
;; Because I can't find a way to utilize it.
(add-hook *after-init-hook*
          (lambda ()
            (setf (variable-value 'frame-multiplexer :global) nil))
          -1)

;; Allow to suspend Lem by C-z.
;; It doesn't work well on Mac with Apple Silicon.
#+(and lem-ncurses (not (and darwin arm64)))
(progn
  (define-command suspend-editor () ()
    (charms/ll:endwin)
    (sb-posix:kill (sb-posix:getpid) sb-unix:sigtstp))

  (define-key *global-keymap* "C-z" 'suspend-editor))
