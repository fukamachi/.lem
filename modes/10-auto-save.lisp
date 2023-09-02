(defpackage #:lem-my-init/modes/auto-save
  (:use #:cl
        #:lem
        #:lem/auto-save))
(in-package #:lem-my-init/modes/auto-save)

(setf (lem:variable-value 'lem/auto-save::auto-save-checkpoint-frequency :global) 0.5)
(setf (lem:variable-value 'lem/auto-save::auto-save-key-count-threshold :global) 0)

(lem/auto-save::auto-save-mode t)
