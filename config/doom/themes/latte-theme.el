;;; doom-dracula-theme.el - based on https://draculatheme.com/ -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-dracula-theme nil
  "Options for the `doom-dracula' theme."
  :group 'doom-themes)

(defcustom doom-dracula-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-dracula-theme
  :type 'boolean)

(defcustom doom-dracula-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-dracula-theme
  :type 'boolean)

(defcustom doom-dracula-colorful-headers nil
  "If non-nil, headers in org-mode will be more colorful; which is truer to the
original Dracula Emacs theme."
  :group 'doom-dracula-theme
  :type 'boolean)

(defcustom doom-dracula-comment-bg doom-dracula-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-dracula-theme
  :type 'boolean)

(defcustom doom-dracula-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-dracula-theme
  :type '(choice integer boolean))

;;
(def-doom-theme latte
  "A dark theme based on Dracula theme"

  ;; name        default   256       16
  ((bg         '("#eff1f5" "#eff1f5" "black"        ))
   (bg-alt     '("#eff1f5" "#eff1f5" "black"        ))
   (base0      '("#e6e9ef" "#e6e9ef" "black"        ))
   (base1      '("#eff1f5" "#eff1f5" "brightblack"  ))
   (base2      '("#ccd0da" "#ccd0da" "brightblack"  ))
   (base3      '("#bcc0cc" "#bcc0cc" "brightblack"  ))
   (base4      '("#acb0be" "#acb0be" "brightblack"  ))
   (base5      '("#9ca0b0" "#9ca0b0" "brightblack"  ))
   (base6      '("#8c8fa1" "#8c8fa1" "brightblack"  ))
   (base7      '("#7c7f93" "#7c7f93" "brightblack"  ))
   (base8      '("#6c6f85" "#6c6f85" "white"        ))
   (fg         '("#4c4f69" "#4c4f69" "white"        ))
   (fg-alt     '("#5c5f77" "#5c5f77" "brightwhite"  ))

   (grey       base4)
   (red        '("#d20f39" "#d20f39" "red"          ))
   (orange     '("#fe640b" "#fe640b" "brightred"    ))
   (green      '("#40a02b" "#40a02b" "green"        ))
   (teal       '("#179299" "#179299" "brightgreen"  ))
   (yellow     '("#df8e1d" "#df8e1d" "yellow"       ))
   (blue       '("#04a5e5" "#04a5e5" "brightblue"   ))
   (dark-blue  '("#1e66f5" "#1e66f5" "blue"         ))
   (magenta    '("#dc8a78" "#dc8a78" "magenta"      ))
   (violet     '("#8839ef" "#8839ef" "brightmagenta"))
   (cyan       '("#209fb5" "#209fb5" "brightcyan"   ))
   (dark-cyan  '("#209fb5" "#209fb5" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      violet)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        dark-blue)
   (comments       (if doom-dracula-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-dracula-brighter-comments dark-cyan base5) 0.25))
   (constants      red)
   (functions      dark-blue)
   (keywords       violet)
   (methods        teal)
   (operators      red)
   (type           magenta)
   (strings        green)
   (variables      (doom-lighten red 0.3))
   (numbers        violet)
   (region         `(,(car base3) ,@(cdr base1)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (level1 magenta)
   (level2 violet)
   (level3 (if doom-dracula-colorful-headers green   (doom-lighten violet 0.35)))
   (level4 (if doom-dracula-colorful-headers yellow  (doom-lighten magenta 0.35)))
   (level5 (if doom-dracula-colorful-headers cyan    (doom-lighten violet 0.6)))
   (level6 (if doom-dracula-colorful-headers orange  (doom-lighten magenta 0.6)))
   (level7 (if doom-dracula-colorful-headers blue    (doom-lighten violet 0.85)))
   (level8 (if doom-dracula-colorful-headers magenta (doom-lighten magenta 0.85)))
   (level9 (if doom-dracula-colorful-headers violet  (doom-lighten violet 0.95)))

   (-modeline-bright doom-dracula-brighter-modeline)
   (-modeline-pad
    (when doom-dracula-padded-modeline
      (if (integerp doom-dracula-padded-modeline) doom-dracula-padded-modeline 4)))

   (region-alt `(,(car base3) ,@(cdr base4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken magenta 0.6)
      `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken  magenta 0.675)
      `(,(car bg) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg) 0.075) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-dracula-comment-bg (doom-lighten bg 0.05)))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; company
   (company-tooltip-selection     :background base3)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground violet)
   (css-property             :foreground violet)
   (css-selector             :foreground green)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; helm
   (helm-bookmark-w3m :foreground violet)
   (helm-buffer-not-saved :foreground violet)
   (helm-buffer-process :foreground orange)
   (helm-buffer-saved-out :foreground fg)
   (helm-buffer-size :foreground fg)
   (helm-candidate-number :foreground bg :background fg)
   (helm-ff-directory :foreground green :weight 'bold)
   (helm-ff-executable :foreground dark-blue :inherit 'italic)
   (helm-ff-invalid-symlink :foreground magenta :weight 'bold)
   (helm-ff-prefix :foreground bg :background magenta)
   (helm-ff-symlink :foreground magenta :weight 'bold)
   (helm-grep-finish :foreground base2)
   (helm-grep-running :foreground green)
   (helm-header :foreground base2 :underline nil :box nil)
   (helm-moccur-buffer :foreground green)
   (helm-separator :foreground violet)
   (helm-source-go-package-godoc-description :foreground yellow)
   ((helm-source-header &override) :foreground magenta)
   (helm-time-zone-current :foreground orange)
   (helm-time-zone-home :foreground violet)
   (helm-visible-mark :foreground bg :background base3)
   ;;;; highlight-quoted-mode
   (highlight-quoted-symbol :foreground cyan)
   (highlight-quoted-quote  :foreground magenta)
   ;;;; js2-mode
   (js2-external-variable :foreground violet)
   (js2-function-param :foreground cyan)
   (js2-jsdoc-html-tag-delimiter :foreground yellow)
   (js2-jsdoc-html-tag-name :foreground dark-blue)
   (js2-jsdoc-value :foreground yellow)
   (js2-private-function-call :foreground cyan)
   (js2-private-member :foreground base7)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-darken 'bg 0.075))
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground level1)
   (outline-2 :inherit 'outline-1 :foreground level2)
   (outline-3 :inherit 'outline-2 :foreground level3)
   (outline-4 :inherit 'outline-3 :foreground level4)
   (outline-5 :inherit 'outline-4 :foreground level5)
   (outline-6 :inherit 'outline-5 :foreground level6)
   (outline-7 :inherit 'outline-6 :foreground level7)
   (outline-8 :inherit 'outline-7 :foreground level8)
   ;;;; org <built-in>
   (org-agenda-date :foreground cyan)
   (org-agenda-dimmed-todo-face :foreground comments)
   (org-agenda-done :foreground base4)
   (org-agenda-structure :foreground violet)
   ((org-block &override) :background (doom-darken base1 0.125) :foreground violet)
   ((org-block-begin-line &override) :background (doom-darken base1 0.125) :foreground comments)
   ((org-code &override) :foreground yellow)
   (org-column :background base1)
   (org-column-title :background base1 :bold t :underline t)
   (org-date :foreground cyan)
   ((org-document-info &override) :foreground blue)
   ((org-document-info-keyword &override) :foreground comments)
   (org-done :foreground green :background base2 :weight 'bold)
   (org-footnote :foreground blue)
   (org-headline-base :foreground comments :strike-through t :bold nil)
   (org-headline-done :foreground base4 :strike-through nil)
   ((org-link &override) :foreground orange)
   (org-priority :foreground cyan)
   ((org-quote &override) :background (doom-darken base1 0.125))
   (org-scheduled :foreground green)
   (org-scheduled-previously :foreground yellow)
   (org-scheduled-today :foreground orange)
   (org-sexp-date :foreground base4)
   ((org-special-keyword &override) :foreground yellow)
   (org-table :foreground violet)
   ((org-tag &override) :foreground (doom-lighten orange 0.3))
   (org-todo :foreground orange :bold 'inherit :background (doom-darken base1 0.02))
   (org-upcoming-deadline :foreground yellow)
   (org-warning :foreground magenta)
   ;;;; rjsx-mode
   (rjsx-tag :foreground magenta)
   (rjsx-attr :foreground green :slant 'italic :weight 'medium)
   ;;;; solaire-mode
   (solaire-hl-line-face :background base2)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   (solaire-region-face :background region-alt)
   ;;;; web-mode
   (web-mode-builtin-face :foreground orange)
   (web-mode-css-selector-face :foreground green)
   (web-mode-html-attr-name-face :foreground green)
   (web-mode-html-tag-bracket-face :inherit 'default)
   (web-mode-html-tag-face :foreground magenta :weight 'bold)
   (web-mode-preprocessor-face :foreground orange))

  ;;;; Base theme variable overrides-
  ()
  )

;;; doom-dracula-theme.el ends here
