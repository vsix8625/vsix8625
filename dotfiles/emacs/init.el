(setq package-enable-at-startup nil)
(setq custom-file-inhibit-initialize t)

(setq load-prefer-newer t)

;; -alh Dired
(setq dired-listing-switches "-alh")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'package)
(setq initial-buffer-choice "/devenv/projects") 
(setq inhibit-startup-echo-area-message "vsix")

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

;; storm-mode for sk
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'storm-mode)

(require 'ansi-color)
(defun vsix/ansi-color-compilation-filter ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook 'vsix/ansi-color-compilation-filter)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq inhibit-startup-screen t)

;; short answers (y / n)
(setq use-short-answers t)

;; if want Dired to kill buffer when navigate dirs
(setq dired-kill-when-opening-new-dired-buffers t)

(setq isearch-lazy-count t)
(setq lazy-highlight-initial-delay 0)
(setq isearch-allow-motion t)
(save-place-mode 1)
(global-set-key (kbd "RET") 'newline-and-indent)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; other-window
(global-set-key (kbd "C-<tab>") 'other-window)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

;; directory for auto-saves
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

;; directory for backups
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups/"))))
(setq backup-by-copying t)


(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; keys

(keymap-global-set "C-<left>"  #'previous-buffer)
(keymap-global-set "C-<right>" #'next-buffer)

;; delete other windows
(global-set-key (kbd "C-c o") (kbd "C-x 1"))

(setq compile-command "sk strike --profile")
(global-set-key (kbd "C-c c") 'compile)

(global-set-key (kbd "C-c r")
                (lambda () (interactive) (async-shell-command "sk surge")))

(global-set-key (kbd "C-c R")
                (lambda ()
                  (interactive)
                  (let* ((target (read-string "Target (blank = latest): "))
                         (args (read-string "Args (blank = none): ")))
                    (async-shell-command
                     (string-trim
                      (concat "sk surge "
                              target
                              (unless (string-empty-p args) (concat " ::: " args))))))))

(global-set-key (kbd "<f1>") (lambda () (interactive) (dired "~/.config/emacs/")))


;; packages

(use-package avy
  :ensure t
  :bind ("C-;" . avy-goto-char))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'zeus t))

(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode)

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)                  

  (corfu-auto-delay 0.1)         
  (corfu-auto-prefix 2)          
  (corfu-quit-no-match 'separator)
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ("<tab>" . corfu-next)
              ("S-TAB" . corfu-previous)
              ("<backtab>" . corfu-previous)
              ("RET" . corfu-insert)
              ("<return>" . corfu-insert))
  :hook (prog-mode . global-corfu-mode))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  (treesit-auto-langs '(c cpp python yaml toml))
  :config
  (treesit-auto-add-to-auto-mode-alist '(c cpp python yaml toml))
  (global-treesit-auto-mode))

(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode))

(use-package magit
  :ensure t)

(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

(require 'eglot)
;; Eglot Performance Adjustments
(setq eglot-sync-connect 0)
(setq read-process-output-max (* 1024 1024))

(setq-default eglot-ignored-server-capabilities '(:inlayHintProvider))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-ts-mode c-mode) . ("clangd" "--header-insertion=never"))))

(with-eval-after-load 'c-ts-mode
  (define-key c-ts-mode-map (kbd "C-c k") 'eldoc-doc-buffer)
  (define-key c-ts-mode-map (kbd "C-c a") 'eglot-code-actions))

(add-hook 'c-ts-mode-hook 'eglot-ensure)

(add-hook 'c-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'eglot-format-buffer nil t)))

(setq c-ts-mode-indent-offset 4)
(setq treesit-font-lock-level 4) 

;;(add-hook 'after-load-functions
;;          (lambda (path)
;;            (let ((package-name (file-name-base path)))
;;              (message "Package loaded successfully: %s" package-name))))
;;

(message "Emacs: (Ready in %s)" (emacs-init-time))



