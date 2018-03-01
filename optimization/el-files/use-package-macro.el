;; restart emacs 
(use-package restart-emacs
  :ensure t
  :bind* (("C-x M-c" . restart-emacs)))


;;Dired file browser minimal set up.
(use-package dired
  :bind (:map dired-mode-map
              ("C-c C-e" . wdired-change-to-wdired-mode))
  :init
  (setq dired-dwim-target t
        dired-recursive-copies 'top
        dired-recursive-deletes 'top
        dired-listing-switches "-alh")
  :config
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))


;;Checks for spellings in programming comments
(use-package flyspell
  :diminish (flyspell-mode . "φ")
  :bind* (("M-m ] s" . flyspell-goto-next-error)))


;;gives you key hints on delay or if prompted
(use-package which-key
  :ensure t
  :defer t
  :diminish which-key-mode
  :init
  (setq which-key-sort-order 'which-key-key-order-alpha)
  :bind* (("M-m ?" . which-key-show-top-level))
  :config
  (which-key-mode)
  (which-key-add-key-based-replacements
    "M-m ?" "top level bindings"))

;; Discover my major bindings
(use-package discover-my-major
  :ensure t
  :bind (("C-h C-m" . discover-my-major)
         ("C-h M-m" . discover-my-mode)))

;; Bind key to bind some unbound defaults
(bind-keys*
  ("C-r"       . dabbrev-expand)
  ("M-/"       . hippie-expand)
  ("C-S-d"     . kill-whole-line)
  ("M-m SPC c" . load-theme)
  ("M-m SPC R" . locate)
  ("M-m W"     . winner-undo)
  ("M-m g m"   . make-frame)
  ("M-m g M"   . delete-frame)
  ("M-m g n"   . select-frame-by-name)
  ("M-m g N"   . set-frame-name)
  ("M-m B"     . mode-line-other-buffer)
  ("M-m ="     . indent-region)
  ("M-m g ("   . Info-prev)
  ("M-m g )"   . Info-next)
  ("M-m ^"     . Info-up)
  ("M-m &"     . Info-goto-node)
  ("M-m g f"   . find-file-at-point)
  ("M-m g u"   . downcase-region)
  ("M-m g U"   . upcase-region)
  ("M-m g C"   . capitalize-region)
  ("M-m g F"   . follow-mode)
  ("M-m R"     . overwrite-mode)
  ("M-m g j"   . doc-view-next-page)
  ("M-m g k"   . doc-view-previous-page)
  ("M-m : t"   . emacs-init-time)
  ("M-m g q"   . fill-paragraph)
  ("M-m g @"   . compose-mail)
  ("M-m SPC ?" . describe-bindings))


