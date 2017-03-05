;; integrate a neotree file extension
(add-to-list 'load-path "~/.emacs.d/configs/packages/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)


;; highlight-sysmbol configurations
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;quick-match abbrevation,substrings and their combinations.
(add-to-list 'load-path "~/.emacs.d/configs/packages/flx")
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq gc-cons-threshold 20000000)

;;jumping around in emacs
(add-to-list 'load-path "~/.emacs.d/configs/packages/ace-jump-mode")
    (require 'ace-jump-mode)
    (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
