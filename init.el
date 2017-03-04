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


;keyboard bindings.
(load-user-file "~/.emacs.d/configs/keyboard.el")

;plugin config file.
(load-user-file "~/.emacs.d/configs/plugins.el")

;emacs GUI config file.
(load-user-file "~/.emacs.d/configs/interface.el")

;programming-modes config file.
(load-user-file "~/.emacs.d/configs/programming.el")
