



;;  Python programming set up
(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :config
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i"))



(use-package anaconda-mode
  :ensure t
  :defer 2
  :diminish anaconda-mode
  :diminish anaconda-eldoc-mode
  :bind (:map python-mode-map
              ("C-c I" . anaconda-mode-show-doc)
              ("C-c S" . anaconda-mode-find-definitions))
  :config
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)))


(use-package pyenv-mode
  :ensure t
  :commands (pyenv-mode
             pyenv-mode-set
             pyenv-mode-unset))


(use-package py-yapf
  :ensure t
  :commands (py-yapf-buffer
             py-yapf-enable-on-save))


(use-package sphinx-doc
  :ensure t
  :diminish sphinx-doc-mode
  :commands (sphinx-doc
             sphinx-doc-mode))


(use-package pytest
  :ensure t
  :commands (pytest-all
             pytest-directory
             pytest-failed
             pytest-module
             pytest-one
             pytest-pdb-all
             pytest-pdb-directory
             pytest-pdb-module
             pytest-pdb-one))



(use-package web-mode
  :ensure t
  :mode ("\\.html$" . web-mode))


(use-package js3-mode
  :ensure t
  :mode ("\\.js$" . js3-mode))


(use-package scss-mode
  :ensure t
  :mode "\\.scss$")


(use-package json-mode
  :ensure t
  :mode "\\.json$")


(use-package nginx-mode
  :ensure t
  :commands (nginx-mode))


(use-package emmet-mode
  :ensure t
  :diminish (emmet-mode . "ε")
  :bind* (("C-)" . emmet-next-edit-point)
          ("C-(" . emmet-prev-edit-point))
  :commands (emmet-mode
             emmet-next-edit-point
             emmet-prev-edit-point))



(use-package impatient-mode
  :ensure t
  :diminish (impatient-mode . "ι")
  :commands (impatient-mode))


(use-package tern
  :ensure t
  :diminish tern-mode
  :defer 2
  :config
  (progn
    (add-hook 'js-mode-hook '(lambda () (tern-mode t)))))



(use-package skewer-mode
  :ensure t
  :diminish skewer-mode
  :commands (skewer-mode
             skewer-html-mode
             skewer-css-mode
             run-skewer
             skewer-repl
             list-skewer-clients
             skewer-eval-defun
             skewer-eval-last-expression
             skewer-eval-print-last-expression
             skewer-load-buffer
             skewer-bower-load
             skewer-bower-refresh
             skewer-run-phantomjs
             skewer-phantomjs-kill))



(use-package nodejs-repl
  :ensure t
  :commands (nodejs-repl
             nodejs-repl-send-buffer
             nodejs-repl-switch-to-repl
             nodejs-repl-send-region
             nodejs-repl-send-last-sexp
             nodejs-repl-execute
             nodejs-repl-load-file))



(use-package nvm
  :ensure t
  :commands (nvm-use
             nvm-use-for))



(use-package json-snatcher
  :ensure t
  :commands (jsons-print-path))


(use-package web-beautify
  :ensure t
  :commands (web-beautify-css
             web-beautify-css-buffer
             web-beautify-html
             web-beautify-html-buffer
             web-beautify-js
             web-beautify-js-buffer))


(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :defer 2
  :bind* (("M-m ] l"   . flycheck-next-error)
          ("M-m [ l"   . flycheck-previous-error)
          ("M-m SPC l" . flycheck-list-errors))
  :config
  (global-flycheck-mode))


(use-package company
  :ensure t
  :commands (company-mode
             company-complete
             company-complete-common
             company-complete-common-or-cycle
             company-files
             company-dabbrev
             company-ispell
             company-c-headers
             company-jedi
             company-tern
             company-web-html
             company-auctex)
  :init
  (setq company-minimum-prefix-length 2
        company-require-match 0
        company-selection-wrap-around t
        company-dabbrev-downcase nil
        company-tooltip-limit 20                      ; bigger popup window
        company-tooltip-align-annotations 't          ; align annotations to the right tooltip border
        company-idle-delay .4                         ; decrease delay before autocompletion popup shows
        company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (eval-after-load 'company
    '(add-to-list 'company-backends '(company-files
                                      company-capf)))
  :bind (("M-t"   . company-complete)
         ("C-c f" . company-files)
         ("C-c a" . company-dabbrev)
         ("C-c d" . company-ispell)
         :map company-active-map
              ("C-n"    . company-select-next)
              ("C-p"    . company-select-previous)
              ([return] . company-complete-selection)
              ("C-w"    . backward-kill-word)
              ("C-c"    . company-abort)
              ("C-c"    . company-search-abort))
  :diminish (company-mode . "ς")
  :config
  (global-company-mode)
  ;; C++ header completion
  (use-package company-c-headers
    :ensure t
    :bind (("C-c c" . company-c-headers))
    :config
    (add-to-list 'company-backends 'company-c-headers))
  ;; Python auto completion
  (use-package company-jedi
    :ensure t
    :bind (("C-c j" . company-jedi))
    :config
    (add-to-list 'company-backends 'company-jedi))
  ;; Tern for JS
  (use-package company-tern
    :ensure t
    :bind (("C-c t" . company-tern))
    :init
    (setq company-tern-property-marker "")
    (setq company-tern-meta-as-single-line t)
    :config
    (add-to-list 'company-backends 'company-tern))
  ;; HTML completion
  (use-package company-web
    :ensure t
    :bind (("C-c w" . company-web-html))
    :config
    (add-to-list 'company-backends 'company-web-html))
  ;; LaTeX autocompletion
  (use-package company-auctex
    :ensure t
    :bind (("C-c l" . company-auctex))
    :config
    (add-to-list 'company-backends 'company-auctex)))



(setq compilation-finish-functions
      (lambda (buf str)
        (if (null (string-match ".*exited abnormally.*" str))
            ;;no errors, make the compilation window go away in a few seconds
            (progn
              (run-at-time "0.4 sec" nil
                           (lambda ()
                             (select-window (get-buffer-window (get-buffer-create "*compilation*")))
                             (switch-to-buffer nil)))
              (message "No Compilation Errors!")))))




