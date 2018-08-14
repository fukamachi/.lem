(defpackage #:lem-my-init/modes/auto-save
  (:use #:cl
        #:lem
        #:lem.auto-save))
(in-package #:lem-my-init/modes/auto-save)

(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (change-buffer-mode buffer 'lem.auto-save::auto-save-mode t)))
(setf (lem:variable-value 'lem.auto-save::auto-save-checkpoint-frequency :global) 0.5)
