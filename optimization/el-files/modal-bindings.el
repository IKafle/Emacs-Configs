
;; Modalka mode ("M-m") - Awesome package
(use-package modalka
  :ensure t
  :demand t
  :bind* (("C-z" . modalka-mode))
  :diminish (modalka-mode . "μ")
  :init
  (setq modalka-cursor-type 'box)
  :config
  (global-set-key (kbd "<escape>") #'modalka-mode)
  (modalka-global-mode 1)
  (add-to-list 'modalka-excluded-modes 'magit-status-mode)
  (add-to-list 'modalka-excluded-modes 'magit-popup-mode)
  (add-to-list 'modalka-excluded-modes 'eshell-mode)
  (add-to-list 'modalka-excluded-modes 'deft-mode)
  (add-to-list 'modalka-excluded-modes 'term-mode)
  (which-key-add-key-based-replacements
    "M-m"     "Modalka prefix"
    "M-m :"   "extended prefix"
    "M-m m"   "move prefix"
    "M-m s"   "send code prefix"
    "M-m SPC" "user prefix"
    "M-m g"   "global prefix"
    "M-m o"   "org prefix"
    "M-m a"   "expand around prefix"
    "M-m i"   "expand inside prefix"
    "M-m ["   "prev nav prefix"
    "M-m ]"   "next nav prefix"))


;;lets you define sticky bindings 
(use-package hydra
  :ensure t)


;; Vi based bindings
;(modalka-define-kbd "h" "C-b")
;(modalka-define-kbd "j" "C-n")
;(modalka-define-kbd "k" "C-p")
;(modalka-define-kbd "l" "C-f")

