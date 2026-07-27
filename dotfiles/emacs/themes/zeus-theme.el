;;; zeus-theme.el --- High-contrast dark theme, green/blue accents, white strings -*- lexical-binding: t; -*-

(deftheme zeus
  "High-contrast dark theme with green/blue accents and white strings.")

(let ((bg              "#0d1114")
      (fg              "#5995b4")
      (comment-fg      "#39434f")
      (string-fg       "#ffffff")
      (number-fg       "#B66149")
      (boolean-fg      "#A45B5E")
      (constant-fg     "#008888")
      (identifier-fg   "#008888")
      (keyword-fg      "#004444")
      (operator-fg     "#a9c5f4")
      (special-fg      "#004444")
      (type-fg         "#0074af")
      (function-fg     "#16406D")
      (preproc-fg      "#004444")
      (title-fg        "#118599")
      (cursor-bg       "#11f4b1")
      (cursorline-bg   "#1f1f1f")
      (cursorlinenr-fg "#babaff")
      (linenr-fg       "#29332f")
      (search-bg       "#3a5268")
      (search-fg       "#e5e9f0")
      (visual-bg       "#2d3b4d")
      (visual-fg       "#d8dee9")
      (lazy-bg         "#24303b")
      (lazy-fg         "#a3b1c2")
      (pmenu-bg        "#454140")
      (pmenu-fg        "#ffffff")
      (error-bg        "#9F0e21")
      (error-fg        "#0f0f0f")
      (warning-bg      "#ef6400")
      (warning-fg      "#0f0f0f")
      (added-fg        "#777777")
      (changed-fg      "#999999")
      (removed-fg      "#F11122"))

  (custom-theme-set-faces
   'zeus

   `(default ((t (:background ,bg :foreground ,fg))))
   `(cursor ((t (:background ,cursor-bg))))
   `(region ((t (:background ,visual-bg :foreground ,visual-fg :weight bold))))
   `(fringe ((t (:background ,bg))))
   `(vertical-border ((t (:foreground ,identifier-fg))))
   `(window-divider ((t (:foreground ,identifier-fg))))

   `(line-number ((t (:background ,bg :foreground ,linenr-fg))))
   `(line-number-current-line ((t (:background ,bg :foreground ,cursorlinenr-fg :weight bold))))
   `(hl-line ((t (:background ,cursorline-bg))))
   
   `(font-lock-string-face ((t (:foreground ,string-fg))))
   `(font-lock-comment-face ((t (:foreground ,comment-fg))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comment-fg))))
   `(font-lock-keyword-face ((t (:foreground ,keyword-fg :weight bold))))
   `(font-lock-type-face ((t (:foreground ,type-fg :weight bold))))
   `(font-lock-constant-face ((t (:foreground ,constant-fg :weight bold))))
   `(font-lock-builtin-face ((t (:foreground ,special-fg :weight bold))))
   `(font-lock-function-name-face ((t (:foreground ,function-fg :weight bold))))
   `(font-lock-variable-name-face ((t (:foreground ,identifier-fg))))
   `(font-lock-preprocessor-face ((t (:foreground ,preproc-fg :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,operator-fg))))
   `(font-lock-warning-face ((t (:foreground ,warning-bg :weight bold))))
   `(font-lock-number-face ((t (:foreground ,number-fg))))     
   `(font-lock-operator-face ((t (:foreground ,operator-fg)))) 
   `(font-lock-bracket-face ((t (:foreground ,operator-fg))))  
   `(font-lock-delimiter-face ((t (:foreground ,operator-fg))))

   `(isearch ((t (:background ,search-bg :foreground ,search-fg))))
   `(lazy-highlight ((t (:background ,search-bg :foreground ,search-fg))))
   `(isearch-fail ((t (:foreground ,error-bg))))

   `(show-paren-match ((t (:foreground ,special-fg :weight bold))))
   `(show-paren-mismatch ((t (:foreground ,error-bg :weight bold))))
   
   `(mode-line ((t (:background ,lazy-bg :foreground ,lazy-fg))))
   `(mode-line-inactive ((t (:background ,bg :foreground ,comment-fg))))

   `(corfu-default ((t (:background ,pmenu-bg :foreground ,pmenu-fg))))
   `(corfu-current ((t (:background ,visual-bg :foreground ,visual-fg :weight bold))))
   `(corfu-border ((t (:foreground ,fg))))

   `(error ((t (:foreground ,error-bg :weight bold))))
   `(warning ((t (:foreground ,warning-bg :weight bold))))
   `(success ((t (:foreground ,identifier-fg :weight bold))))
   `(flymake-error ((t (:underline (:style wave :color ,error-bg)))))
   `(flymake-warning ((t (:underline (:style wave :color ,warning-bg)))))
   `(flymake-note ((t (:underline (:style wave :color ,comment-fg)))))

   `(diff-added ((t (:foreground ,added-fg))))
   `(diff-changed ((t (:foreground ,changed-fg))))
   `(diff-removed ((t (:foreground ,removed-fg))))

   `(minibuffer-prompt ((t (:foreground ,title-fg :weight bold))))
   `(link ((t (:foreground ,preproc-fg :underline t))))
   `(shadow ((t (:foreground ,comment-fg))))

   `(diredfl-dir-heading ((t (:background ,bg :foreground ,identifier-fg :weight bold))))
   `(diredfl-number ((t (:foreground ,fg))))
   `(diredfl-date-time ((t (:foreground ,comment-fg))))
   `(diredfl-dir-name ((t (:foreground ,identifier-fg))))             
   `(diredfl-file-name ((t (:foreground ,string-fg))))                
   `(diredfl-symlink ((t (:foreground "#87CEFA"))))                   
   `(diredfl-exec-priv ((t (:foreground "#FFA500" :weight bold))))    
   `(diredfl-no-priv ((t (:foreground ,comment-fg))))                 
   `(diredfl-ignored-file-name ((t (:foreground ,comment-fg))))       
   `(diredfl-dir-priv ((t (:foreground ,identifier-fg))))
   `(diredfl-read-priv ((t (:foreground ,fg))))
   `(diredfl-write-priv ((t (:foreground ,fg))))

   `(storm-boolean-face ((t (:foreground ,boolean-fg :weight bold))))


   ))


(provide-theme 'zeus)

