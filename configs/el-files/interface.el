; language
(setq current-language-environment "English")

;start emacs in full screen mode.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; don't show the startup screen
(setq inhibit-startup-screen t)

;hide scroll bars
(scroll-bar-mode -1)

; number of characters until the fill column
(setq fill-column 70)

;set theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/configs/themes/cyberpunk-theme")
(load-theme 'cyberpunk t)

;disable toolbar 
(tool-bar-mode -1) 

(global-hl-line-mode 1) ; turn on highlighting current line
