(setq gc-cons-threshold (* 50 1024 1024)) ; 50MB

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

(setq package-quickstart t)

(add-to-list 'default-frame-alist '(font . "JetBrainsMono NF Medium-18"))
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024)))) 
