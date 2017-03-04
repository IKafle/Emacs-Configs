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
(load-theme 'manoj-dark)

;disable toolbar 
(tool-bar-mode -1) 
