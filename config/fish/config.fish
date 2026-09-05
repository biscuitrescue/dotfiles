set -x EDITOR "nvim"
set -x BAT_THEME "ansi"
set fish_greeting
set -x RANGER_LOAD_DEFAULT_RC "FALSE"
set TERM "xterm-256color"
set COLORTERM "truecolor"
set -x MANPAGER "nvim +Man!"

set -gx FZF_DEFAULT_OPTS '
  --color=bg+:#293334,bg:#0c0c0c,spinner:#da627d,hl:#F02D3A
  --color=fg:#bdc4a7,header:#987284,info:#7e8dba,pointer:#9FC490
  --color=marker:#9FC490,fg+:#cecece,prompt:#70AE6E,hl+:#F45B69
  --color=selected-bg:#1a1a1a
  --color=border:#393D3F,label:#F49D6E,query:#F7F0F5
  --border="thinblock"
  --border-label=" Onyx "
  --border-label-pos="0"
  --preview-window="border-thinblock"
  --prompt="> "
  --marker="▶"
  --pointer="◆"
  --separator="─"
  --scrollbar="│"
  --info="right"'

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/scripts/bash"
fish_add_path "$HOME/scripts/python"
fish_add_path "$HOME/git/zls/zig-out/bin/"
fish_add_path "$HOME/scripts/c"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.config/emacs/bin"

set fish_color_normal cyan
set fish_color_autosuggestion brgrey
set fish_color_command green # '#50fa7b'
set fish_color_error red #'#ff5555'
set fish_color_quote yellow

fish_default_key_bindings

alias wcc="warp-cli connect"
alias wdd="warp-cli disconnect"
alias vim="nvim"
alias v="nvim"
alias ":q"="exit"
### GIT
alias clone="git clone"
alias pull="git pull"
alias add="git add"
alias rmm="git rm"
alias remlist="git remote -v"
alias commit="git commit"
alias branch="git branch"
alias addrem="git remote add"
alias rmrem="git remote remove"
alias push="git push"
alias init="git init"
alias save="git config --global credential.helper store"
alias checkout="git checkout"

# Gentoo
# alias gentup="sudo emerge -avuDN --with-bdeps y @world"
# alias remerge="sudo emerge -ca"
# alias clean="sudo eclean-dist -d && sudo revdep-rebuild"

# Arch
# alias up="paru -Syu --sudoloop"
# alias mirror="sudo reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist"
# alias nosleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
# alias yesleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"

# NixOS
alias ns="nix-shell"
alias ncg="sudo nix-collect-garbage --delete-older-than 1d"
alias up="sudo nixos-rebuild switch --flake /home/cafo/nixos#cafo --upgrade-all"
alias reb="sudo nixos-rebuild switch --flake /home/cafo/nixos#cafo"

alias lg="lazygit"

# Exa
alias ll='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ls='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | grep -E "^\."'

# X11
alias bstart='startx /usr/bin/bspwm'
alias openstart='startx /usr/bin/openbox-session'
alias dstart='startx /usr/local/bin/dwm'

# Fancy
alias pipes="pipes-rs -k curved -p 3 -t 0.13 -r 0.6"
alias fetch="fastfetch"

# Tmux
alias tmsource="tmux source-file ~/.config/tmux/tmux.conf"
alias tmux="tmux -u"
alias mux="tmux new-session -t shell"

function getc
	gcc -dM -E - < /dev/null | grep __STDC_VERSION__ | awk '{ print $2 " --> " $3 }'
end

function ipub
	echo (drill myip.opendns.com @resolver1.opendns.com | awk '/myip/ {printf $5}')
end

starship init fish | source
direnv hook fish | source
any-nix-shell fish --info-right | source
