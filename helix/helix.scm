(require (prefix-in helix. "helix/commands.scm"))

(require (prefix-in helix.static. "helix/static.scm"))
(require "helix/editor.scm")

(require "helix/misc.scm")

(provide  open-init-scm)

;;@doc
;; Opens the init.scm file
(define (open-init-scm)
  (helix.open (helix.static.get-init-scm-path)))
