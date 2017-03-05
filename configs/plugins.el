;; integrate a neotree file extension
(add-to-list 'load-path "/opt/neotree")
  (require 'neotree)
  (global-set-key [f8] 'neotree-toggle)


;; highlight-sysmbol configurations
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

