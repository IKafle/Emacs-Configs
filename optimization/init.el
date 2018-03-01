;;; init.el --- Global settings -*- lexical-binding: t; -*-

;;; Commentary:

;; Here be dragons

;; code

;; https://sriramkswamy.github.io/dotemacs/

;; Increase the garbage collection threshold to 500 MB to ease startup
(setq gc-cons-threshold (* 500 1024 1024))


;; List package archives and initialize them
(require 'package)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)  

;;use-package-macro
(load-user-file "~/.emacs.d/configs/el-files/use-package-macro.el")

;;Modalka mode, vi like bindings
(load-user-file "~/.emacs.d/configs/el-files/modal-bindings.el")

;default settings
(load-user-file "~/.emacs.d/configs/el-files/defaults.el")

;keyboard bindings.
(load-user-file "~/.emacs.d/configs/el-files/keyboard.el")

; File navigations.
(load-user-file "~/.emacs.d/configs/el-files/navigation.el")

;Eye Candy and stuff.
(load-user-file "~/.emacs.d/configs/el-files/eye-candy.el")

;Eye Candy and stuff.
(load-user-file "~/.emacs.d/configs/el-files/programming.el")

;; Garbage collector - decrease threshold to 5 MB
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 5 1024 1024))))
;;; init.el ends here
