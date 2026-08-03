(setq gc-cons-threshold (* 400 1024 1024))

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

(setq package-quickstart t)

(add-to-list 'default-frame-alist '(font . "JetBrainsMono NF Medium-18"))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)))) 
