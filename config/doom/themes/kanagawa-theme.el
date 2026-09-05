;;; doom-palenight-theme.el --- adapted from equinusocio's Material themes -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: August 8, 2019 (7c7e871f2221)
;; Author: Brettm12345 <https://github.com/Brettm12345>
;; Maintainer:
;; Source: https://github.com/equinusocio/vsc-material-theme
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-palenight-theme nil
  "Options for the `doom-palenight' theme."
  :group 'doom-themes)

(defcustom doom-palenight-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-palenight-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme kanagawa
    "A dark theme inspired by Material-Palenight"

  ;; name        default   256       16
  ((bg         '("#181616" nil       nil))
   (bg-alt     '("#181616" nil       nil))
   (base0      '("#393836" "black"   "black"))

   (base1      '("#181616" "#181616" "brightblack"  ))
   (base2      '("#393F45" "#393F45" "brightblack"  ))
   (base3      '("#45475a" "#45475a" "brightblack"  ))
   (base4      '("#585b70" "#585b70" "brightblack"  ))
   (base5      '("#6c7086" "#6c7086" "brightblack"  ))
   (base6      '("#7f849c" "#7f849c" "brightblack"  ))
   (base7      '("#ccccc7" "#cccccc" "brightblack"  ))
   (base8      '("#f8f8f2" "#dfdfdf" "white"        ))
   (fg         '("#c5c9c5" "#DCD7BA" "brightwhite"))
   (fg-alt     '("#9e9b93" "#ffffff" "white"))

   (grey base5)

   (red         '("#e46976" "#c4746e" "red"))
   (orange      '("#ffa066" "#ffa066" "brightred"))
   (green       '("#87a987" "#8a9a7b" "green"))
   (teal        '("#8ea49e" "#8ea49e" "brightgreen"))
   (yellow      '("#e6c384" "#c4b28a" "brightyellow"))
   (blue        '("#7fb4ca" "#8ba4b0" "brightblue"))
   (dark-blue   '("#7e9cd8" "#7e9cd8" "blue"))
   (magenta     '("#938aa9" "#a292a3" "brightmagenta"))
   (violet      '("#d27e99" "#d27e99" "magenta"))
   (cyan        '("#7aa89f" "#8ea4a2" "brightcyan"))
   (dark-cyan   '("#80cbc4" "#00d7af" "cyan"))

   ;; face categories -- required for all themes
   (highlight      violet)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        dark-blue)
   (comments       base5)
   (doc-comments   (doom-lighten base5 0.25))
   (constants      red)
   (functions      blue)
   (keywords       magenta)
   (methods        teal)
   (operators      red)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten violet 0.3))
   (numbers        violet)
   (region         `(,(car base3) ,@(cdr base1)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)
   ;; (highlight      (doom-lighten magenta 0.25))
   ;; (vertical-bar   base2)
   ;; (selection      base4)
   ;; (builtin        blue)
   ;; (comments       base5)
   ;; (doc-comments   (doom-lighten base5 0.25))
   ;; (constants      orange)
   ;; (functions      blue)
   ;; (keywords       (doom-lighten magenta 0.25))
   ;; (methods        blue)
   ;; (operators      yellow)
   ;; (type           (doom-lighten magenta 0.25))
   ;; (strings        green)
   ;; (variables      yellow)
   ;; (numbers        orange)
   ;; (region         base3)
   ;; (error          red)
   ;; (warning        yellow)
   ;; (success        green)
   ;; (vc-modified    blue)
   ;; (vc-added       green)
   ;; (vc-deleted     red)

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
