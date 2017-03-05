; delete a character or word  
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(setq indent-tabs-mode nil); always use spaces, not tabs, when indenting

(setq case-fold-search t); ignore case when searching

(global-set-key [f4] 'goto-line); set the keybinding so that you can use f4 for goto line

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

(electric-pair-mode 1); insert right brackets when left one is typed

(setq make-backup-files nil) ; stop creating those backup~ files

;smooth scrolling.
(global-set-key [M-up] (lambda () (interactive) (scroll-up 1)))
(global-set-key [M-down] (lambda () (interactive) (scroll-down 1)))
