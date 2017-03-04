; language
(setq current-language-environment "English")

; don't show the startup screen
(setq inhibit-startup-screen t)

; don't show the menu bar
(menu-bar-mode nil)

; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode nil)

; don't show the scroll bar
(scroll-bar-mode nil)

; number of characters until the fill column
(setq fill-column 70)

; turn on mouse wheel support for scrolling
(require 'mwheel)
(mouse-wheel-mode t)
