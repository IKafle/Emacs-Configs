;; Intractin with tmux
(use-package emamux
  :ensure t
  :commands (emamux:send-command
             emamux:run-command
             emamux:run-last-command
             emamux:zoom-runner
             emamux:inspect-runner
             emamux:close-runner-pane
             emamux:close-panes
             emamux:clear-runner-history
             emamux:interrupt-runner
             emamux:copy-kill-ring
             emamux:yank-from-list-buffers))


;; Hydra tmux interation
(defhydra sk/hydra-for-emamux (:color red
                               :hint nil)
 "
 ^Command^    ^Runner^                          ^Clipboard^
^^^^^^^^^^-----------------------------------------------------------------
 _s_: send    _r_: run        _c_: close          _y_: copy kill    _q_: quit
            _l_: last cmd   _C_: close other    _p_: paste tmux
            _z_: zoom       _h_: clear hist
            _i_: inspect    _I_: interrupt
"
 ("s" emamux:send-command)
 ("r" emamux:run-command)
 ("l" emamux:run-last-command)
 ("z" emamux:zoom-runner)
 ("i" emamux:inspect-runner)
 ("c" emamux:close-runner-pane)
 ("C" emamux:close-panes)
 ("h" emamux:clear-runner-history)
 ("I" emamux:interrupt-runner)
 ("y" emamux:copy-kill-ring)
 ("p" emamux:yank-from-list-buffers)
 ("q" nil :color blue))


(bind-keys*
 ("M-m s t" . sk/hydra-for-emamux/body))


;; Weather info
(use-package wttrin
  :ensure t
  :commands (wttrin)
  :init
  (setq wttrin-default-cities '("Kathmandu"
                                "Albuquerque"
                                "Chennai"
                                "Hyderabad"
                                "Columbus"
                                "Hillsboro")))



;; How do i do somethin
(use-package howdoi
  :ensure t
  :bind* (("M-m g Y"   . howdoi-query)
          ("M-m SPC y" . howdoi-query-line-at-point)
          ("M-m SPC Y" . howdoi-query-insert-code-snippet-at-point)))


;; Use xkcd in emacs
(use-package xkcd
  :ensure t
  :commands (xkcd)
  :bind* (("M-m g X" . xkcd)))


;; Keep track of financial accounts
(use-package ledger-mode
  :ensure t
  :mode "\\.dat$")


;; Gtalk - to talk from with an emacs
;; Jabber
(use-package jabber
  :ensure t
  :commands (jabber-connect)
  :init
  (setq jabber-history-enabled t
        jabber-activity-mode nil
        jabber-use-global-history nil
        jabber-backlog-number 40
        jabber-backlog-days 30)
  (setq jabber-alert-presence-message-function
        (lambda (who oldstatus newstatus statustext) nil)))



;; IRC
(use-package circe
  :ensure t
  :commands (circe))



;; Learn the most frequently used keys
(use-package keyfreq
  :ensure t
  :init
  (setq keyfreq-excluded-commands
        '(self-insert-command
          org-self-insert-command
          company-ignore
          abort-recursive-edit
          forward-char
          modalka-mode
          backward-char
          previous-line
          next-line))
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))


;; GooGle stuff
(use-package google-this
  :ensure t
  :commands (google-this-word
             google-this-region
             google-this-symbol
             google-this-clean-error-string
             google-this-line
             google-this-search
             google-this-cpp-reference))


(defun sk/google-this ()
  "Google efficiently"
  (interactive)
  (if (region-active-p)
      (google-this-region 1)
    (google-this-symbol 1)))


(bind-keys*
 ("M-m A" . sk/google-this))


;; hydra for GooGle stuff
(defhydra sk/hydra-google (:color blue
                           :hint nil)
  "
 _w_: word   _r_: region    _v_: symbol   _l_: line
 _g_: google _c_: cpp       _s_: string   _q_: quit
 "
  ("w" google-this-word)
  ("r" google-this-region)
  ("v" google-this-symbol)
  ("s" google-this-clean-error-string)
  ("l" google-this-line)
  ("g" google-this-search)
  ("c" google-this-cpp-reference)
  ("q" nil :color blue))

(bind-keys*
  ("M-m g G" . sk/hydra-google/body))
