
(require "term.scm")
(require "splash.scm")
(require "vim-hx/init.scm")
(require "focus.scm")
;;(require "mattwparas-helix-package/cogs/git-status-picker.scm")
;;(require "mattwparas-helix-package/init.scm")


(set-vim-keybindings!)

(when (equal? (command-line) '("hx"))
  (show-splash))
