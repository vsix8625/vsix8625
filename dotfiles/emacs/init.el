;; -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil)
(setq custom-file-inhibit-initialize t)

(setq load-prefer-newer t)
(setq ido-auto-merge-work-directories-length -1)

;; prevent TRAMP altering theme
;; (setq tramp-default-proxies-alist nil)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror+)

(require 'package)
(setq initial-buffer-choice "/devenv") 
(setq inhibit-startup-echo-area-message "vsix")

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

(global-set-key (kbd "C-x C-c") 'delete-frame)
(global-set-key (kbd "C-x C-M-c") 'save-buffers-kill-emacs)

(repeat-mode 1)
(setq compilation-skip-threshold 2)
(setq compilation-search-path '("." "src" ".."))

;; storm-mode for sk
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'storm-mode)

(require 'ansi-color)

(defun user/ansi-color-compilation-filter ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region compilation-filter-start (point))))

(add-hook 'compilation-filter-hook 'user/ansi-color-compilation-filter)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq inhibit-startup-screen t)

;; short answers (y / n)
;;(setq use-short-answers t)

;; if want Dired to kill buffer when navigate dirs
(setq dired-kill-when-opening-new-dired-buffers t)
(setq dired-listing-switches "-alh")

(setq isearch-lazy-count t)
(setq lazy-highlight-initial-delay 0)
(setq isearch-allow-motion t)
(save-place-mode 1)

;; shadow completion mode
(global-completion-preview-mode 1)

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

(keymap-global-set "C-{"  #'previous-buffer)
(keymap-global-set "C-}" #'next-buffer)

;; delete other windows
(global-set-key (kbd "C-c C-o") (kbd "C-x 1"))

(ido-mode 1)
(ido-everywhere 1)

;; auto save pre-compile
(setq compilation-ask-about-save nil)
;; auto-scroll in compile
(setq compilation-scroll-output 'first-error)
(setq compile-command "sk strike")

;;; Storm-Knell (sk) Commands
(defun sk/compile-profile ()
  "Compile using sk strike with profiling."
  (interactive)
  (compile "sk strike --profile"))

(defun sk/dry-compile-verbose ()
  "DRY and verbose run."
  (interactive)
  (compile "sk strike --dry --verbose"))

(defun sk/compile-autorun ()
  "Compile using sk autorun."
  (interactive)
  (compile "sk autorun"))

(defun sk/clean ()
  "Run sk clean."
  (interactive)
  (compile "sk clean"))

(defun sk/clean-full ()
  "Run sk clean with --full flag."
  (interactive)
  (compile "sk clean --full"))

(defun sk/surge ()
  "Run sk surge asynchronously."
  (interactive)
  (compile "sk surge"))

(defun sk/surge-interactive ()
  "Run sk surge with interactively prompted target and arguments."
  (interactive)
  (let* ((target (read-string "Target (blank = latest): "))
         (args (read-string "Args (blank = none): ")))
    (compile
     (string-trim
      (concat "sk surge "
              target
              (unless (string-empty-p args) (concat " ::: " args)))))))

;; keybinds
(global-set-key (kbd "C-c c") #'sk/compile-profile)
(global-set-key (kbd "C-c v") #'sk/dry-compile-verbose)
(global-set-key (kbd "C-c C") #'sk/compile-autorun)
(global-set-key (kbd "C-c t") #'sk/clean)
(global-set-key (kbd "C-c T") #'sk/clean-full)
(global-set-key (kbd "C-c r") #'sk/surge)
(global-set-key (kbd "C-c R") #'sk/surge-interactive)

;;--------------------------------------------------------------------------------------------

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

  (corfu-auto-delay 3)         
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

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "e") 'dired-up-directory))


;;(require 'eglot)

;; Eglot Performance Adjustments
(setq eglot-sync-connect 0)
(setq read-process-output-max (* 1024 1024))
(setq eglot-events-buffer-size 0)

;; kill auto idle-trigger
(setq eldoc-idle-delay 2.0)

(setq-default eglot-ignored-server-capabilities '(:inlayHintProvider
						  :documentHighlightProvider
						  :signatureHelpProvider
						  :publishDiagnosticsProvider))

(with-eval-after-load 'jsonrpc
  (defun jsonrpc--log-event (&rest _) nil))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-ts-mode c-mode) . ("clangd"
				       "--header-insertion=never"
  				       "--background-index")))
  (define-key eglot-mode-map (kbd "C-c %") 'eglot-rename)
)

(with-eval-after-load 'c-ts-mode
  (define-key c-ts-mode-map (kbd "C-c k") 'eldoc-doc-buffer)
  (define-key c-ts-mode-map (kbd "C-c a") 'eglot-code-actions))

;; load eglot on demand
(defun user/eglot-ensure ()
  (interactive)
  (eglot-ensure))

(with-eval-after-load 'c-ts-mode
  (define-key c-ts-mode-map (kbd "C-c l") #'user/eglot-ensure))

;; auto format on save running clang-format process 
(defun user/clang-format-buffer ()
  (interactive)
  (let ((pos (point))
        (file (or buffer-file-name "stdin.c")))
    (call-process-region
     (point-min)
     (point-max)
     "clang-format"
     t
     t
     nil
     "--assume-filename" file)
    (goto-char (min pos (point-max)))))

(add-hook 'c-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'user/clang-format-buffer nil t)))

(setq c-ts-mode-indent-offset 4)
(setq treesit-font-lock-level 4) 

;; find-other-file-project
(defun user/jump-to-other-file ()
  "Switch between .c and .h files"
  (interactive)
  (let* ((current-file (buffer-file-name))
         (current-dir (and current-file (file-name-directory current-file)))
         (base-name   (and current-file (file-name-base current-file)))
         (root-dir (and current-dir
                        (locate-dominating-file current-dir 
                                                (lambda (dir)
                                                  (or (file-exists-p (expand-file-name ".git" dir))
                                                      (file-exists-p (expand-file-name ".storm" dir))
                                                      (file-exists-p (expand-file-name ".project" dir))
                                                      (file-exists-p (expand-file-name "Makefile" dir))
                                                      (file-exists-p (expand-file-name ".root" dir))))))))
    (if (not current-file)
        (message "File not found")
      (if (not root-dir)
          (message "No project anchor found")
        (let* ((pattern (concat "^" (regexp-quote base-name) "\\.[a-zA-Z0-9]+$"))
               (all-matches (directory-files-recursively root-dir pattern))
               (other-matches (cl-remove current-file all-matches :test #'string=)))
          (if other-matches
              (find-file (car other-matches))
            (message "No matching pair found for '%s.*' in project root." base-name)))))))

;; key map	
(global-set-key (kbd "M-o") 'user/jump-to-other-file)
;; end of user/jump-to-other-file

(defun user/open-line-above()
  "Insert line above"
  (interactive)
  (beginning-of-line)
  (open-line 1)
  (indent-according-to-mode))

(global-set-key (kbd "C-o") 'user/open-line-above)

(defun user/kill-to-end-of-buffer ()
  "Kill from current cursor position to the end of the buffer."
  (interactive)
  (kill-region (point) (point-max)))

(global-set-key (kbd "C-c C-d") 'user/kill-to-end-of-buffer)

;;-----------------------------------------------------------------------

(defun user/my-copy-line(arg)
  "Copy ARG lines without killing them"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-k") 'user/my-copy-line)

(defun grep-sys (symbol)
  "Search /usr/include for SYMBOL using ripgrep."
  (interactive "sSystem Symbol: ")
  (let ((term (string-trim symbol)))
    (if (string-empty-p term)
        (user-error "Search term cannot be empty!")
      (grep (format "rg --vimgrep -w %s /usr/include"
                    (shell-quote-argument term))))))

;; end of init.el			     
(message "Emacs: (Ready in %s)" (emacs-init-time))



(put 'downcase-region 'disabled nil)
