;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Karttikeya Sinha"
      user-mail-address "karttikeyasinha11@gmail.com")

(setq auto-save-default t
      make-backup-files t)

(setq confirm-kill-emacs nil)

(setq scroll-margin 0)
(setq indent-tabs-mode t
      tab-width 2)

(setq doom-theme 'bamboo)
(setq doom-font (font-spec :family "Monaspace Neon NF" :size 15))
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

(after! flycheck
  (setq flycheck-disabled-checkers '(c/c++-clang c/c++-gcc)))

(after! lsp-clangd
  (setq lsp-clients-clangd-executable "clangd"))


(setq package-install-upgrade-built-in t)

(setq term-terminal-parameter '("xterm-256color"))

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

(map! :leader
      :desc "Open Dired Window"
      "-" #'dired-jump)

(map! :leader
      :desc "Open Dired Window"
      "f =" #'dired-create-empty-file)

(map! "M-e" #'evil-end-of-line
      "M-w" #'evil-first-non-blank)
