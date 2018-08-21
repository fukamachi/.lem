(defsystem "lem-my-init"
  :author "Eitaro Fukamachi"
  :license "BSD 2-Clause"
  :description "Configurations for lem"
  :serial t
  :depends-on ("lem-trailing-spaces")
  :components ((:file "modes/10-vi")
               (:file "modes/10-paredit")
               (:file "modes/10-auto-save")
               (:file "modes/10-trailing-spaces")
               (:file "modes/20-lisp-mode")))
