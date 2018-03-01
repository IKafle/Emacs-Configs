;; personal information
(setq user-full-name "Ishwor Kafle")

;;tell Emacs to store automatic inserting of some code  to a separate file instead of init.el and load it if it exists.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;Disabling some GUI elements 
(when window-system
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (tooltip-mode 0))

;;Disabling some GUI elements
;; initial window
(setq initial-frame-alist
      '((width . 102)   ; characters in a line
        (height . 54))) ; number of lines

;; sebsequent frame
(setq default-frame-alist
      '((width . 100)   ; characters in a line
        (height . 52))) ; number of lines

;;Set the cursor shape
;; Bar cursor
(setq-default cursor-type '(bar . 1))
;; Don't blink the cursor
(blink-cursor-mode -1)


;; Initial screen
;; No welcome screen - opens directly in scratch buffer
(setq inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      inhibit-splash-screen t)

;; Startup echo message
(defun display-startup-echo-area-message ()
  (message "Ishwor,Let the games begin!"))

;;keeps various versions of the backup file and stores it under a folder in the home directory.
;; Backups at .saves folder in the current folder
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups


;;AutoSaving: ask Emacs to store its backups in some temporary directory.
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      create-lockfiles nil)

;; File encoding system
(prefer-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-auto-unix)

;;ignore the audible warning.
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;;Truncating lines:
;;make sure code stays within 100 characters always and prefer the soft line wrap while writing prose
(setq-default truncate-lines t)

;;increase file size limit
(setq large-file-warning-threshold (* 15 1024 1024))

;; Lazier prompting; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Expand some word and auto correct them
(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

;;multi-windowed debugger
(setq gdb-many-windows t
      gdb-show-main t)

;; to help resolve merge conflicts and having some better defaults
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)

;;Tramp: edit files remotely from your local Emacs ;; default protocol is ssh
(setq tramp-default-method "ssh"
      tramp-backup-directory-alist backup-directory-alist
      tramp-ssh-controlmaster-options "ssh")


;;Emacs thinks a sentence is a full-stop followed by 2 spaces. Let’s make it full-stop and 1 space.
(setq sentence-end-double-space nil)

;;Recenter screen- defaults goes to top first
(setq recenter-positions '(top middle bottom))

;;Better wild cards in search
(setq search-whitespace-regexp ".*?")

;;persistent history for some prompts.
(savehist-mode)

;;enable Narrow to region
(put 'narrow-to-region 'disabled nil)

;;Doc view mode: eg: PDF
(setq doc-view-continuous t)

;; Window management
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Recent files mode:
;; Recentf mode changes
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))
(recentf-mode)

