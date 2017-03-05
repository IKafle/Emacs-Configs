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

;common utils and key-bindings.
(load-user-file "~/.emacs.d/configs/el-files/general.el")

;keyboard bindings.
(load-user-file "~/.emacs.d/configs/el-files/keyboard.el")

;plugin config file.
(load-user-file "~/.emacs.d/configs/packages/highlight-symbol/highlight-symbol.el")
(load-user-file "~/.emacs.d/configs/el-files/plugins.el")

;emacs GUI config file.
(load-user-file "~/.emacs.d/configs/el-files/interface.el")

;programming-modes config file.
(load-user-file "~/.emacs.d/configs/el-files/programming.el")
 
;custom keystrokes and functions.
(load-user-file "~/.emacs.d/configs/el-files/custom-bindings.el")
