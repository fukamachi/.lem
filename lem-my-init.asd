(defsystem "lem-my-init"
  :author "Eitaro Fukamachi"
  :license "BSD 2-Clause"
  :description "Configurations for lem"
  :serial t
  :depends-on ("lem-trailing-spaces"
               "lem-lisp-mode"
               "lem-vi-mode"
               "lem-vi-sexp")
  :components ((:file "modes/vi")
               (:file "modes/auto-save")
               (:file "modes/trailing-spaces")
               (:file "modes/lisp-mode")))
