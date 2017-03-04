; delete a character or word  -- summery
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

; always use spaces, not tabs, when indenting
(setq indent-tabs-mode nil)

; ignore case when searching
(setq case-fold-search t)

; set the keybinding so that you can use f4 for goto line
(global-set-key [f4] 'goto-line)

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)
