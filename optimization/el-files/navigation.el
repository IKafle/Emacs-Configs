
;; Fuzzy file narrowing like sublime text
(use-package flx-ido
  :ensure t
  :defer t)


;; helps order the M-x commands based on usage and recent items
(use-package smex
  :ensure t
  :config
  (smex-initialize))


;; utility that indicates the cursor position when the cursor moves suddenly
(use-package beacon
  :ensure t
  :demand t
  :diminish beacon-mode
  :bind* (("M-m g z" . beacon-blink))
  :config
  (beacon-mode 1))


;; Undo Redo tree
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :bind* (("M-m u" . undo-tree-undo)
          ("M-m r" . undo-tree-redo)
          ("M-m U" . undo-tree-visualize))
  :config
  (global-undo-tree-mode 1))

;; Goto the last change
(use-package goto-chg
  :ensure t
  :bind* (("M-m g ;" . goto-last-change)
          ("M-m g ," . goto-last-change-reverse)))


;; Avy -  package that lets you jump anywhere on screen based on character, characters, lines or words
(use-package avy
  :ensure t
  :init
  (setq avy-keys-alist
        `((avy-goto-char-timer . (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))
          (avy-goto-line . (?j ?k ?l ?f ?s ?d ?e ?r ?u ?i))))
  (setq avy-style 'pre)
  :bind* (("M-m f" . avy-goto-char-timer)
          ("M-m F" . avy-goto-line)))

;;  highlight the current word or symbol and navigate to other instances.
(use-package highlight-symbol
  :ensure t
  :bind (("M-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev))
  :config
  (highlight-symbol-nav-mode))


;; Projectile -package for project navigation

(use-package projectile
  :ensure t
  :bind* (("M-m SPC d"   . projectile-find-file)
          ("M-m SPC D"   . projectile-switch-project)
          ("M-m SPC TAB" . projectile-find-other-file))
  :init
  (setq projectile-file-exists-remote-cache-expire (* 10 60))
  :diminish projectile-mode
  :config
  (projectile-global-mode))

;; Ztree - ztree-diff is super useful when comparing directory trees.
(use-package ztree
  :ensure t
  :bind* (("M-m g v" . ztree-dir)
          ("M-m g V" . ztree-diff))
  :init
  (setq ztree-dir-move-focus t))

;; Neotree - Directory drawer popular in all the modern text editors
(use-package neotree
  :ensure t
  :bind* (("M-m SPC n". neotree-toggle))
  :init
  (setq neo-smart-open t))

;; ggtags - Tags based navigation
(use-package ggtags
  :ensure t
  :diminish ggtags-mode
  :bind* (("M-m T"   . ggtags-find-tag-regexp)
          ("M-m g t" . ggtags-create-tags)
          ("M-m g T" . ggtags-update-tags))
  :init
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  :config
  (add-hook 'prog-mode-hook 'ggtags-mode))


;; Perspective -creates different view ports in Emacs preserving the Window configuration. Super useful.
(use-package perspective
  :ensure t
  :bind* (("M-m SPC p" . persp-switch)
          ("M-m SPC P" . persp-kill)
          ("M-m SPC A" . persp-switch-to-buffer)
          ("M-m g r"   . persp-rename))
  :config
  (persp-mode 1))

;; Zoom window - Toggle zoom window
(use-package zoom-window
  :ensure t
  :bind* (("M-m Z" . zoom-window-zoom)))

;; Non native full screen
(defun sk/toggle-frame-fullscreen-non-native ()
  "Toggle full screen non-natively. Uses the `fullboth' frame paramerter
   rather than `fullscreen'. Useful to fullscreen on OSX w/o animations."
  (interactive)
  (modify-frame-parameters
   nil
   `((maximized
      . ,(unless (memq (frame-parameter nil 'fullscreen) '(fullscreen fullboth))
           (frame-parameter nil 'fullscreen)))
     (fullscreen
      . ,(if (memq (frame-parameter nil 'fullscreen) '(fullscreen fullboth))
             (if (eq (frame-parameter nil 'maximized) 'maximized)
                 'maximized)
           'fullboth)))))

(bind-keys*
 ("M-m SPC z" . sk/toggle-frame-fullscreen-non-native))


;; Split window and move
(defun sk/split-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1))
(defun sk/split-right-and-move ()
  (interactive)
  (split-window-right)
  (other-window 1))

(bind-keys
  ("C-x 2" . sk/split-below-and-move)
  ("C-x 3" . sk/split-right-and-move))



;; Turn the adjoining window (only with 2 windows)
(defun sk/other-window-down ()
  "Scrolls down in adjoining window"
  (interactive)
  (other-window 1)
  (scroll-up-command)
  (other-window 1))
(defun sk/other-window-up ()
  "Scrolls up in adjoining window"
  (interactive)
  (other-window 1)
  (scroll-down-command)
  (other-window 1))

(bind-keys*
  ("M-m g ]" . sk/other-window-down)
  ("M-m g [" . sk/other-window-up))


;;  Turn the adjoining  pdf only with two windows.
(defun sk/other-pdf-next ()
  "Turns the next page in adjoining PDF file"
  (interactive)
  (other-window 1)
  (doc-view-next-page)
  (other-window 1))
(defun sk/other-pdf-previous ()
  "Turns the previous page in adjoining PDF file"
  (interactive)
  (other-window 1)
  (doc-view-previous-page)
  (other-window 1))


(bind-keys*
  ("M-m ] d" . sk/other-pdf-next)
  ("M-m [ d" . sk/other-pdf-previous))


;; Rotate the windows
(defun sk/rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(bind-keys*
 ("M-m R" . sk/rotate-windows))


 ;;   Hydra - window navigation
 (defhydra sk/hydra-of-windows (:color red
                               :hint nil)
  "
 ^Move^    ^Size^    ^Change^                    ^Split^           ^Text^
 ^^^^^^^^^^^------------------------------------------------------------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^   _u_: winner-undo _o_: rotate  _v_: vertical     _+_: zoom in
 _h_ ^+^ _l_   _H_ ^+^ _L_   _r_: winner-redo            _s_: horizontal   _-_: zoom out
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^   _c_: close                  _z_: zoom         _q_: quit
"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("H" shrink-window-horizontally)
  ("K" shrink-window)
  ("J" enlarge-window)
  ("L" enlarge-window-horizontally)
  ("v" sk/split-right-and-move)
  ("s" sk/split-below-and-move)
  ("c" delete-window)
  ("f" sk/toggle-frame-fullscreen-non-native :color blue)
  ("o" sk/rotate-windows)
  ("z" delete-other-windows)
  ("u" (progn
         (winner-undo)
         (setq this-command 'winner-undo)))
  ("r" winner-redo)
  ("+" text-scale-increase)
  ("-" text-scale-decrease)
  ("q" nil :color blue))

 (bind-keys*
  ("M-m SPC u" . sk/hydra-of-windows/body))


 ;; Easy commenting
 (use-package comment-dwim-2
  :ensure t
  :bind* (("M-m g c" . comment-dwim-2)))


 ;; Multiple cursors
 (use-package multiple-cursors
  :ensure t
  :bind* (("M-m ." . mc/edit-lines)
          ("M-m >" . mc/mark-next-like-this)
          ("M-m ," . mc/skip-to-next-like-this)
          ("M-m <" . mc/mark-previous-like-this)))

 ;; Shrink white space
 (use-package shrink-whitespace
  :ensure t
  :bind* (("M-m g SPC" . shrink-whitespace)))

 ;; Visual replace - find and replace with y/n/!
 (use-package visual-regexp
  :ensure t
  :commands (vr/query-replace)
  :bind* (("M-m SPC SPC" . vr/query-replace))
  :config
  (use-package visual-regexp-steroids
    :ensure t
    :commands (vr/select-query-replace)))

 
 ;; Cycle quotes - helps to cycle quotes when in strings.
 (use-package cycle-quotes
  :ensure t
  :bind* (("M-m s q" . cycle-quotes)))

 ;; Increase or decrease number at point
 (defun sk/incs (s &optional num)
  (let* ((inc (or num 1))
         (new-number (number-to-string (+ inc (string-to-number s))))
         (zero-padded? (s-starts-with? "0" s)))
    (if zero-padded?
        (s-pad-left (length s) "0" new-number)
      new-number)))

(defun sk/change-number-at-point (arg)
  (interactive "p")
  (unless (or (looking-at "[0-9]")
              (looking-back "[0-9]"))
    (sk/goto-closest-number))
  (save-excursion
    (while (looking-back "[0-9]")
      (forward-char -1))
    (re-search-forward "[0-9]+" nil)
    (replace-match (sk/incs (match-string 0) arg) nil nil)))

(defun sk/subtract-number-at-point (arg)
  (interactive "p")
  (sk/change-number-at-point (- arg)))

(bind-keys*
  ("M-m g +" . sk/change-number-at-point)
  ("M-m g -" . sk/subtract-number-at-point))


;; Deactivate region
(defun sk/remove-mark ()
  "Deactivate the region"
  (interactive)
  (if (region-active-p)
      (deactivate-mark)))

(bind-keys*
 ("M-m E" . sk/remove-mark))


;; Insert date or date time
(defun sk/insert-date (prefix)
  "Insert the current date. With prefix-argument, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d")
                 ((equal prefix '(4)) "%A, %d %B %Y")
                 ((equal prefix '(16)) "%Y-%m-%d %H:%M:%S"))))
    (insert (format-time-string format))))

(bind-keys*
 ("M-m g D" . sk/insert-date))


;; Rename the current buffer and the file associated with it
(defun sk/rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(bind-keys*
 ("M-m g R" . sk/rename-current-buffer-file))


;; Delete the current buffer and the file associated with it
(defun sk/delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(bind-keys*
 ("M-m g K" . sk/delete-current-buffer-file))


;; copy the current file path
(defun sk/copy-current-file-path ()
  "Add current file path to kill ring. Limits the filename to project root if possible."
  (interactive)
  (kill-new buffer-file-name))

(bind-keys*
 ("M-m g y" . sk/copy-current-file-path))


;; Transpose words forward or backward
;; Transpose words forward
(defun sk/transpose-words-forward ()
  "Transpose words forward"
  (interactive)
  (forward-word 1)
  (forward-char 1)
  (transpose-words 1)
  (backward-word 1))
;; Transpose words backward
(defun sk/transpose-words-backward ()
  "Transpose words backward"
  (interactive)
  (transpose-words 1)
  (backward-word 1))


(bind-keys*
  ("M-m [ w" . sk/transpose-words-backward)
  ("M-m ] w" . sk/transpose-words-forward))


;; Transpose the characters forward or backward
;; Transpose chars forward
(defun sk/transpose-chars-forward ()
  "Transpose chars forward"
  (interactive)
  (forward-char 1)
  (transpose-chars 1)
  (backward-char 1))
;; Transpose chars backward
(defun sk/transpose-chars-backward ()
  "Transpose chars backward"
  (interactive)
  (transpose-chars 1)
  (backward-char 1))

(bind-keys*
  ("M-m [ c" . sk/transpose-chars-backward)
  ("M-m ] c" . sk/transpose-chars-forward))


;; Copy to the end of the line
(defun sk/copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point)
                  (line-end-position))
  (message "Copied to end of line"))

(bind-keys*
 ("M-m Y" . sk/copy-to-end-of-line))


;; Duplicate the selected line or region
(defun sk/duplicate-region (&optional num start end)
  "Duplicates the region bounded by START and END NUM times.
If no START and END is provided, the current region-beginning and
region-end is used."
  (interactive "p")
  (save-excursion
    (let* ((start (or start (region-beginning)))
           (end (or end (region-end)))
           (region (buffer-substring start end)))
      (goto-char end)
      (dotimes (i num)
        (insert region)))))

(defun sk/duplicate-current-line (&optional num)
  "Duplicate the current line NUM times."
  (interactive "p")
  (save-excursion
    (when (eq (point-at-eol) (point-max))
      (goto-char (point-max))
      (newline)
      (forward-char -1))
    (sk/duplicate-region num (point-at-bol) (1+ (point-at-eol)))))

(defun sk/duplicate-line-or-region (&optional num)
  "Duplicate the current line or region if active"
  (interactive "p")
  (if (region-active-p)
      (let ((beg (region-beginning))
            (end (region-end)))
        (sk/duplicate-region num beg end)))
  (sk/duplicate-current-line num))

(bind-keys*
 ("M-m g d" . sk/duplicate-line-or-region))


;; Insert a new line above the current on
(defun sk/open-line-above (args)
  "Insert a new line above the current one or open a new line above for editing"
  (interactive "P")
  (if (equal args '(4))
      (save-excursion
        (unless (bolp)
          (beginning-of-line))
        (newline)
        (indent-according-to-mode))
    (unless (bolp)
      (beginning-of-line))
    (newline)
    (forward-line -1)
    (indent-according-to-mode)
    (modalka-mode 0)))

(bind-keys*
 ("M-o" . sk/open-line-above))


;; Join the next line with the next line
(defun sk/join-line ()
  "Join the current line with the next line"
  (interactive)
  (next-line)
  (delete-indentation))

(bind-keys
 ("C-S-j" . sk/join-line))

;; Select the current line
(defun sk/select-inside-line ()
  "Select the current line"
  (interactive)
  (sk/smarter-move-beginning-of-line 1)
  (set-mark (line-end-position))
  (exchange-point-and-mark))

(defun sk/select-around-line ()
  "Select line including the newline character"
  (interactive)
  (sk/select-inside-line)
  (next-line 1)
  (sk/smarter-move-beginning-of-line 1))

(bind-keys*
  ("M-m i l" . sk/select-inside-line)
  ("M-m a l" . sk/select-around-line))

;; Move a line or  selected region up or down
(defun sk/move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))
            (forward-line -1)))
        (forward-line -1))
      (move-to-column column t)))))

;; Lets define wrapper function which we bind
(defun sk/move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (sk/move-text-internal arg))
(defun sk/move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (sk/move-text-internal (- arg)))

(bind-keys*
  ("M-m [ e" . sk/move-text-up)
  ("M-m ] e" . sk/move-text-down))

;; change from snake_case to camelCase
(defun sk/replace-next-underscore-with-camel (arg)
  (interactive "p")
  (if (> arg 0)
 (setq arg (1+ arg))) ; 1-based index to get eternal loop with 0
  (let ((case-fold-search nil))
    (while (not (= arg 1))
      (search-forward-regexp "\\b_[a-z]")
      (forward-char -2)
      (delete-char 1)
      (capitalize-word 1)
      (setq arg (1- arg)))))

(bind-keys*
 ("M-m g C" . sk/replace-next-underscore-with-camel))


;; make current word snake case
(defun sk/snakeify-current-word ()
  (interactive)
  (er/mark-word)
  (let* ((beg (region-beginning))
         (end (region-end))
         (current-word (buffer-substring-no-properties beg end))
         (snakified (snake-case current-word)))
    (replace-string current-word snakified nil beg end)))

(defun sk/kebab-current-word ()
  (interactive)
  (er/mark-word)
  (let* ((beg (region-beginning))
         (end (region-end))
         (current-word (buffer-substring-no-properties beg end))
         (kebabed (s-dashed-words current-word)))
    (replace-string current-word kebabed nil beg end)))

(bind-keys*
 ("M-m g _" . sk/snakeify-current-word))


;;Toggle parenthesis between pairs of “()”, “[]” and “{}”.

(defun move-forward-out-of-param ()
  (while (not (looking-at ")\\|, \\| ?}\\| ?\\]"))
    (cond
     ((point-is-in-string-p) (move-point-forward-out-of-string))
     ((looking-at "(\\|{\\|\\[") (forward-list))
     (t (forward-char)))))

(defun move-backward-out-of-param ()
  (while (not (looking-back "(\\|, \\|{ ?\\|\\[ ?"))
    (cond
     ((point-is-in-string-p) (move-point-backward-out-of-string))
     ((looking-back ")\\|}\\|\\]") (backward-list))
     (t (backward-char)))))

(defun transpose-params ()
  "Presumes that params are in the form (p, p, p) or {p, p, p} or [p, p, p]"
  (interactive)
  (let* ((end-of-first (cond
                        ((looking-at ", ") (point))
                        ((and (looking-back ",") (looking-at " ")) (- (point) 1))
                        ((looking-back ", ") (- (point) 2))
                        (t (error "Place point between params to transpose."))))
         (start-of-first (save-excursion
                           (goto-char end-of-first)
                           (move-backward-out-of-param)
                           (point)))
         (start-of-last (+ end-of-first 2))
         (end-of-last (save-excursion
                        (goto-char start-of-last)
                        (move-forward-out-of-param)
                        (point))))
    (transpose-regions start-of-first end-of-first start-of-last end-of-last)))

(bind-keys*
 ("M-m s c" . transpose-params))



;; Expand region hydra
(defhydra sk/hydra-expand (:pre (er/mark-word)
                           :color red
                           :hint nil)
  "
 _a_: add    _r_: reduce   _q_: quit
 "
  ("a" er/expand-region)
  ("r" er/contract-region)
  ("q" nil :color blue))

(bind-keys*
 ("M-m a a" . sk/hydra-expand/body))


;; Multiple cursors hydra
(defhydra sk/hydra-multiple-cursors (:color red
                                     :hint nil)
  "
  _k_: prev         _j_: next         _a_: all     _b_: beg of lines   _q_: quit
  _K_: skip prev    _J_: skip next    _d_: defun   _e_: end of lines
  _p_: unmark prev  _n_: unmark next  _r_: regexp  _l_: lines
"
  ("j" mc/mark-next-like-this)
  ("J" mc/skip-to-next-like-this)
  ("n" mc/unmark-next-like-this)
  ("k" mc/mark-previous-like-this)
  ("K" mc/skip-to-previous-like-this)
  ("p" mc/unmark-previous-like-this)
  ("a" mc/mark-all-like-this :color blue)
  ("d" mc/mark-all-like-this-in-defun :color blue)
  ("r" mc/mark-all-in-region-regexp :color blue)
  ("b" mc/edit-beginnings-of-lines)
  ("e" mc/edit-ends-of-lines)
  ("l" mc/edit-lines :color blue)
  ("q" nil :color blue))

(bind-keys*
 ("C-t" . sk/hydra-multiple-cursors/body))


;; Rectangular mode edit with hydra
(defhydra sk/hydra-rectangle (:pre (rectangle-mark-mode 1)
                              :color pink
                              :hint nil)
  "
 _p_: paste   _r_: replace  _I_: insert
 _y_: copy    _o_: open     _V_: reset
 _d_: kill    _n_: number   _q_: quit
"
  ("h" backward-char nil)
  ("l" forward-char nil)
  ("k" previous-line nil)
  ("j" next-line nil)
  ("y" copy-rectangle-as-kill)
  ("d" kill-rectangle)
  ("x" clear-rectangle)
  ("o" open-rectangle)
  ("p" yank-rectangle)
  ("r" string-rectangle)
  ("n" rectangle-number-lines)
  ("I" string-insert-rectangle)
  ("V" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)) nil)
  ("q" keyboard-quit :color blue))

(bind-keys*
 ("M-m V" . sk/hydra-rectangle/body))


;; Macros : Get used to them
(defhydra sk/hydra-of-macros (:color pink
                              :hint nil)
  "
 _m_: macro  _L_: lossage  _v_: view      _n_: forward    _D_: delete   _q_: quit
 _M_: prev   _E_: edit     _r_: register  _p_: backward   _K_: key
  "
  ("m" kmacro-call-macro)
  ("M" kmacro-call-ring-2nd)
  ("L" kmacro-edit-lossage :color blue)
  ("E" kmacro-edit-macro :color blue)
  ("v" kmacro-view-macro :color blue)
  ("r" kmacro-to-register :color blue)
  ("n" kmacro-cycle-ring-next)
  ("p" kmacro-cycle-ring-previous)
  ("D" kmacro-delete-ring-head :color blue)
  ("K" kmacro-bind-to-key :color blue)
  ("q" nil :color blue))

(bind-keys*
 ("M-m @" . sk/hydra-of-macros/body))


;; Registers - underused feature but get used to them

(defhydra sk/hydra-registers (:color blue
                              :hint nil)
  "
 _a_: append     _c_: copy-to    _j_: jump       _r_: rectangle-copy   _q_: quit
 _i_: insert     _n_: number-to  _f_: frameset   _w_: window-config
 _+_: increment  _p_: point-to
  "
  ("a" append-to-register)
  ("c" copy-to-register)
  ("i" insert-register)
  ("f" frameset-to-register)
  ("j" jump-to-register)
  ("n" number-to-register)
  ("r" copy-rectangle-to-register)
  ("w" window-configuration-to-register)
  ("+" increment-register)
  ("p" point-to-register)
  ("q" nil :color blue))

(bind-keys*
 ("M-m \"" . sk/hydra-registers/body))


