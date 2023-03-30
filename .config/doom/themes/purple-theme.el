;;; doom-palenight-theme.el --- inspired by Material-PaleNight -*- lexical-binding: t; no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-palenight-theme nil
  "Options for the `doom-palenight' theme."
  :group 'doom-themes)

(defcustom doom-palenight-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-palenight-theme
  :type '(choice integer boolean))

;;
(def-doom-theme purple
  "A dark theme inspired by Material-Palenight"

  ;; name        default   256       16
  ((bg         '("#20212C" nil       nil))
   (bg-alt     '("#20212C" nil       nil))
   (base0      '("#1b1c26" "black"   "black"))
   (base1      '("#1e212e" "#262626" "brightblack"))
   (base2      '("#232635" "#303030" "brightblack"))
   (base3      '("#3C435E" "#3a3a3a" "brightblack"))
   (base4      '("#4E5579" "#444444" "brightblack"))
   (base5      '("#676E95" "#585858" "brightblack"))
   (base6      '("#697098" "#626262" "brightblack"))
   (base7      '("#717CB4" "#767676" "brightblack"))
   (base8      '("#A6Accd" "#a8a8a8" "white"))
   (fg         '("#9CA5D6" "#9CA5D6" "brightwhite"))
   (fg-alt     '("#BABFE0" "#BABFE0" "white"))

   (grey base5)

   (red         '("#f07178" "#ff8b92" "red"))
   (orange      '("#F08160" "#FF711D" "brightred"))
   (green       '("#98E886" "#ACE89F" "green"))
   (teal        '("#72FDF9" "#72FDF9" "brightgreen"))
   (yellow      '("#FAF195" "#FAF195" "brightyellow"))
   (blue        '("#7EA6FA" "#7EA6FA" "brightblue"))
   (dark-blue   '("#6B8CD3" "#7A98D7" "blue"))
   (magenta     '("#CF9CF0" "#CF9CF0" "brightmagenta"))
   (violet      '("#bb80b3" "#bb80b3" "magenta"))
   (cyan        '("#89DDFF" "#5fd7ff" "brightcyan"))
   (dark-cyan   '("#80cbc4" "#00d7af" "cyan"))

   ;; face categories -- required for all themes
   (highlight      violet)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        dark-blue)
   (comments       base5)
   (doc-comments   (doom-lighten base5 0.25))
   (constants      red)
   (functions      (doom-lighten red 0.4))
   (keywords       violet)
   (methods        teal)
   (operators      red)
   (type           yellow)
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
   (modeline-bg     base2)
   (modeline-bg-alt (doom-darken bg 0.01))
   (modeline-fg     base8)
   (modeline-fg-alt comments)

   (-modeline-pad
    (when doom-palenight-padded-modeline
      (if (integerp doom-palenight-padded-modeline) doom-palenight-padded-modeline 4))))

  ;;;; Base theme face overrides
  ((lazy-highlight :background base4 :foreground fg :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (tooltip :background (doom-darken bg-alt 0.2) :foreground fg)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; dired-k
   (dired-k-commited :foreground base4)
   (dired-k-modified :foreground vc-modified)
   (dired-k-ignored :foreground cyan)
   (dired-k-added    :foreground vc-added)
   ;;;; doom-modeline
   (doom-modeline-buffer-path       :foreground green :weight 'bold)
   (doom-modeline-buffer-major-mode :inherit 'doom-modeline-buffer-path)
   ;;;; js2-mode
   (js2-jsdoc-tag              :foreground magenta)
   (js2-object-property        :foreground yellow)
   (js2-object-property-access :foreground cyan)
   (js2-function-param         :foreground violet)
   (js2-jsdoc-type             :foreground base8)
   (js2-jsdoc-value            :foreground cyan)
   ;;;; man <built-in>
   (Man-overstrike :inherit 'bold :foreground magenta)
   (Man-underline :inherit 'underline :foreground blue)
   ;;;; org <built-in>
   ((org-block &override) :background base2)
   ((org-block-background &override) :background base2)
   ((org-block-begin-line &override) :background base2)
   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground magenta)
   (rainbow-delimiters-depth-2-face :foreground orange)
   (rainbow-delimiters-depth-3-face :foreground green)
   (rainbow-delimiters-depth-4-face :foreground cyan)
   (rainbow-delimiters-depth-5-face :foreground violet)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground blue)
   (rainbow-delimiters-depth-8-face :foreground teal)
   (rainbow-delimiters-depth-9-face :foreground dark-cyan)
   ;;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground yellow :slant 'italic :weight 'medium)))

;;; doom-palenight-theme.el ends here
