(setq user-full-name "Karttikeya Sinha"
      user-mail-address "karttikeyasinha11@gmail.com")

(setq auto-save-default t
      make-backup-files t)

(setq confirm-kill-emacs nil)

(setq scroll-margin 4)
(setq indent-tabs-mode t
      tab-width 2)

(setq doom-theme 'hojicha)
(setq doom-font (font-spec :family "Fira Code" :size 21))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")
(setq flyspell-issue-welcome-flag nil)

(setq racer-rust-src-path "/home/cafo/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library")
(after! rustic
  (setq lsp-rust-server 'rust-analyzer))

(setq package-install-upgrade-built-in t)

(setq term-terminal-parameter '("xterm-256color"))

(map! :leader
      :desc "Dirvish"
      "-" #'dirvish)

(defhydra hydra-resize (:hint nil)
  "
Resize window
_h_: ← shrink   _l_: → enlarge
_j_: ↓ shrink   _k_: ↑ enlarge
_q_: quit       _RET_: set
"
  ("h" shrink-window-horizontally)
  ("l" enlarge-window-horizontally)
  ("j" shrink-window)
  ("k" enlarge-window)
  ("RET" (message "Window size set!") :exit t)
  ("q" nil :exit t))

(map! :leader
      :desc "Hydra resize window"
      "w r" #'hydra-resize/body)
