(defpackage #:lem-my-init
  (:use #:cl
        #:lem)
  (:import-from #:lem/frame-multiplexer
                #:frame-multiplexer))
(in-package :lem-my-init)

;; Disable Lem's auto recenter
(setf *scroll-recenter-p* nil)

;; Load my init files.
(let ((asdf:*central-registry* (cons #P"~/.lem/" asdf:*central-registry*)))
  (ql:quickload :lem-my-init :silent t))

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

#| ;; Coalton LSP server setting (WIP)
(lem-lsp-mode:define-language-spec (coalton-spec lem-coalton-mode:coalton-mode)
  :language-id "coalton"
  :root-uri-patterns '(".asd")
  :command (lambda (port) `("/Users/eitarofukamachi/common-lisp/coalton-mode/coalton-lsp" ,(princ-to-string port)))
  :connection-mode :tcp)
|#
