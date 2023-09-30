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
(let ((asdf:*central-registry* (append (list #P"~/.lem/"
                                             #P"~/common-lisp/"
                                             (asdf:system-source-directory :lem)
                                             (asdf:system-relative-pathname :lem #P"contrib/trailing-spaces/"))
                                       asdf:*central-registry*)))
  (ql:quickload :lem-my-init))

;; Disable frame-multiplexer, which shows a switcher at the top of the window.
;; I can't find a good way to utilize it.
(remove-hook *after-init-hook* 'lem/frame-multiplexer::enable-frame-multiplexer)

;; Allow to suspend Lem by C-z.
;; It doesn't work well on Mac with Apple Silicon.
#+(and lem-ncurses (not (and darwin arm64)))
(progn
  (define-command suspend-editor () ()
    (charms/ll:endwin)
    (sb-posix:kill (sb-posix:getpid) sb-unix:sigtstp))

  (define-key *global-keymap* "C-z" 'suspend-editor))
