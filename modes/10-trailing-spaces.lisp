(defpackage #:lem-my-init/modes/trailing-spaces
  (:use #:cl
        #:lem
        #:lem-trailing-spaces))
(in-package #:lem-my-init/modes/trailing-spaces)

(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (change-buffer-mode buffer 'lem-trailing-spaces::trailing-spaces t)))
