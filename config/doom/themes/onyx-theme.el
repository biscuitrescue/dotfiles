;;; doom-onyx-theme.el - based on the Onyx AutoTheme
;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(require 'doom-themes)

;;
(defgroup doom-onyx-theme nil
  "Options for the `doom-onyx' theme."
  :group 'doom-themes)

(defcustom doom-onyx-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-onyx-theme
  :type 'boolean)

(defcustom doom-onyx-brighter-comments nil
  "If non-nil, more vivid colors will be used for comments."
  :group 'doom-onyx-theme
  :type 'boolean)

(defcustom doom-onyx-colorful-headers nil
  "If non-nil, headers in org-mode will be more colorful."
  :group 'doom-onyx-theme
  :type 'boolean)

(defcustom doom-onyx-comment-bg doom-onyx-brighter-comments
  "If non-nil, comments will have a subtle, darker background."
  :group 'doom-onyx-theme
  :type 'boolean)

(defcustom doom-onyx-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds padding to the mode-line."
  :group 'doom-onyx-theme
  :type '(choice integer boolean))

;;
(def-doom-theme onyx
  "A dark pastel theme based on the Onyx AutoTheme."

  ;; name        default     256         16
  ((bg         '("#0c0c0c" "#0c0c0c" "black"))
   (bg-alt     '("#0c0c0c" "#0c0c0c" "black"))

   (base0      '("#1a1a1a" "#1a1a1a" "black"))
   (base1      '("#0c0c0c" "#0c0c0c" "black"))
   (base2      '("#293334" "#293334" "brightblack"))
   (base3      '("#393D3F" "#393D3F" "brightblack"))
   (base4      '("#837A75" "#837A75" "brightblack"))
   (base5      '("#837A75" "#837A75" "brightblack"))
   (base6      '("#cecece" "#cecece" "brightwhite"))
   (base7      '("#F7F0F5" "#F7F0F5" "brightwhite"))
   (base8      '("#ffffff" "#ffffff" "white"))

   (fg         '("#bdc4a7" "#bdc4a7" "white"))
   (fg-alt     '("#F7F0F5" "#F7F0F5" "brightwhite"))

   (grey       '("#393D3F" "#393D3F" "brightblack"))

   (red        '("#F02D3A" "#F02D3A" "red"))
   (orange     '("#F49D6E" "#F49D6E" "brightred"))
   (green      '("#9FC490" "#9FC490" "green"))
   (teal       '("#75BBA7" "#75BBA7" "brightgreen"))
   (yellow     '("#F9DF74" "#F9DF74" "yellow"))
   (blue       '("#7e8dba" "#7e8dba" "brightblue"))
   (dark-blue  '("#7180ac" "#7180ac" "blue"))
   (magenta    '("#987284" "#987284" "magenta"))
   (violet     '("#9B5094" "#9B5094" "brightmagenta"))
   (cyan       '("#99EDCC" "#99EDCC" "brightcyan"))
   (dark-cyan  '("#75BBA7" "#75BBA7" "cyan"))

   ;; face categories -- required for all themes
   (highlight      yellow)
   (vertical-bar   base2)
   (selection      base2)
   (builtin        blue)
   (comments       orange)
   (doc-comments   orange)
   (constants      cyan)
   (functions      blue)
   (keywords       fg)
   (methods        teal)
   (operators      red)
   (type           fg)
   (strings        green)
   (variables      yellow)
   (numbers        yellow)
   (region         base2)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (level1 magenta)
   (level2 blue)
   (level3 green)
   (level4 yellow)
   (level5 cyan)
   (level6 orange)
   (level7 dark-blue)
   (level8 violet)
   (level9 magenta)

   (-modeline-bright doom-onyx-brighter-modeline)
   (-modeline-pad
    (when doom-onyx-padded-modeline
      (if (integerp doom-onyx-padded-modeline)
          doom-onyx-padded-modeline
        4)))

   (region-alt base3)

   (modeline-fg
    fg)

   (modeline-fg-alt
    grey)

   ;; Onyx modeline
   ;; onyx-sel-bg = #293334
   (modeline-bg
    '("#293334" "#293334" "brightblack"))

   (modeline-bg-l
    '("#293334" "#293334" "brightblack"))

   ;; Onyx inactive modeline
   ;; onyx-bg = #0c0c0c
   (modeline-bg-inactive
    '("#0c0c0c" "#0c0c0c" "black"))

   (modeline-bg-inactive-l
    '("#0c0c0c" "#0c0c0c" "black")))

  ;;;; Base theme face overrides
  (((line-number &override)
    :foreground grey)

   ((line-number-current-line &override)
    :foreground blue
    :weight 'bold)

   ;; Comments use Onyx orange #F49D6E
   ((font-lock-comment-face &override)
    :foreground orange)

   (mode-line
    :background modeline-bg
    :foreground modeline-fg
    :box
    (if -modeline-pad
        `(:line-width ,-modeline-pad :color ,modeline-bg)))

   (mode-line-inactive
    :background modeline-bg-inactive
    :foreground modeline-fg-alt
    :box
    (if -modeline-pad
        `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))

   (mode-line-emphasis
    :foreground
    (if -modeline-bright base8 highlight))

   ;;;; company
   (company-tooltip-selection
    :background base2)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property
    :foreground violet)

   (css-property
    :foreground violet)

   (css-selector
    :foreground green)

   ;;;; doom-modeline
   (doom-modeline-bar
    :background
    (if -modeline-bright modeline-bg highlight))

   ;;;; elscreen
   (elscreen-tab-other-screen-face
    :background base2
    :foreground bg)

   ;;;; helm
   (helm-bookmark-w3m
    :foreground violet)

   (helm-buffer-not-saved
    :foreground violet)

   (helm-buffer-process
    :foreground orange)

   (helm-buffer-saved-out
    :foreground fg)

   (helm-buffer-size
    :foreground fg)

   (helm-candidate-number
    :foreground bg
    :background fg)

   (helm-ff-directory
    :foreground blue
    :weight 'bold)

   (helm-ff-executable
    :foreground dark-blue
    :inherit 'italic)

   (helm-ff-invalid-symlink
    :foreground magenta
    :weight 'bold)

   (helm-ff-prefix
    :foreground bg
    :background magenta)

   (helm-ff-symlink
    :foreground magenta
    :weight 'bold)

   (helm-grep-finish
    :foreground base2)

   (helm-grep-running
    :foreground green)

   (helm-header
    :foreground base4
    :underline nil
    :box nil)

   (helm-moccur-buffer
    :foreground green)

   (helm-separator
    :foreground violet)

   (helm-source-go-package-godoc-description
    :foreground yellow)

   ((helm-source-header &override)
    :foreground magenta)

   (helm-time-zone-current
    :foreground orange)

   (helm-time-zone-home
    :foreground violet)

   (helm-visible-mark
    :foreground bg
    :background base2)

   ;;;; highlight-quoted-mode
   (highlight-quoted-symbol
    :foreground cyan)

   (highlight-quoted-quote
    :foreground magenta)

   ;;;; js2-mode
   (js2-external-variable
    :foreground violet)

   (js2-function-param
    :foreground cyan)

   (js2-jsdoc-html-tag-delimiter
    :foreground yellow)

   (js2-jsdoc-html-tag-name
    :foreground dark-blue)

   (js2-jsdoc-value
    :foreground yellow)

   (js2-private-function-call
    :foreground cyan)

   (js2-private-member
    :foreground base7)

   ;;;; markdown-mode
   (markdown-markup-face
    :foreground base5)

   (markdown-header-face
    :inherit 'bold
    :foreground red)

   ((markdown-code-face &override)
    :background (doom-darken bg 0.075))

   ;;;; outline <built-in>
   ((outline-1 &override)
    :foreground level1)

   (outline-2
    :inherit 'outline-1
    :foreground level2)

   (outline-3
    :inherit 'outline-2
    :foreground level3)

   (outline-4
    :inherit 'outline-3
    :foreground level4)

   (outline-5
    :inherit 'outline-4
    :foreground level5)

   (outline-6
    :inherit 'outline-5
    :foreground level6)

   (outline-7
    :inherit 'outline-6
    :foreground level7)

   (outline-8
    :inherit 'outline-7
    :foreground level8)

   ;;;; org <built-in>
   (org-agenda-date
    :foreground cyan)

   (org-agenda-dimmed-todo-face
    :foreground comments)

   (org-agenda-done
    :foreground base4)

   (org-agenda-structure
    :foreground violet)

   ((org-block &override)
    :background base0
    :foreground violet)

   ((org-block-begin-line &override)
    :background base0
    :foreground red)

   (org-code
    :foreground yellow)

   (org-column
    :background base1)

   (org-column-title
    :background base1
    :bold t
    :underline t)

   (org-date
    :foreground cyan)

   ((org-document-info &override)
    :foreground blue)

   ((org-document-info-keyword &override)
    :foreground comments)

   (org-done
    :foreground green
    :background base2
    :weight 'bold)

   (org-footnote
    :foreground blue)

   (org-headline-base
    :foreground comments
    :strike-through t
    :bold nil)

   (org-headline-done
    :foreground base4
    :strike-through nil)

   ((org-link &override)
    :foreground cyan)

   (org-priority
    :foreground cyan)

   ((org-quote &override)
    :background base0)

   (org-scheduled
    :foreground green)

   (org-scheduled-previously
    :foreground yellow)

   (org-scheduled-today
    :foreground orange)

   (org-sexp-date
    :foreground base4)

   ((org-special-keyword &override)
    :foreground yellow)

   (org-table
    :foreground violet)

   ((org-tag &override)
    :foreground teal)

   (org-todo
    :foreground red
    :bold 'inherit
    :background bg)

   (org-upcoming-deadline
    :foreground yellow)

   (org-warning
    :foreground red)

   ;;;; rjsx-mode
   (rjsx-tag
    :foreground magenta)

   (rjsx-attr
    :foreground green
    :slant 'italic
    :weight 'medium)

   ;;;; solaire-mode
   (solaire-hl-line-face
    :background base2)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box
    (if -modeline-pad
        `(:line-width ,-modeline-pad :color ,modeline-bg-l)))

   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box
    (if -modeline-pad
        `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   (solaire-region-face
    :background region-alt)

   ;;;; web-mode
   (web-mode-builtin-face
    :foreground orange)

   (web-mode-css-selector-face
    :foreground green)

   (web-mode-html-attr-name-face
    :foreground green)

   (web-mode-html-tag-bracket-face
    :inherit 'default)

   (web-mode-html-tag-face
    :foreground magenta
    :weight 'bold)

   (web-mode-preprocessor-face
    :foreground orange))

  ;;;; Base theme variable overrides
  ()
  )

;;; doom-onyx-theme.el ends here
