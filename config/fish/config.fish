set -x EDITOR "nvim"
set -x BAT_THEME "ansi"
set fish_greeting
set -x RANGER_LOAD_DEFAULT_RC "FALSE"
# set TERM "alacritty"
set TERM "xterm-256color"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -Ux FZF_DEFAULT_OPTS "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/share/bob/nightly/bin"
fish_add_path "$HOME/scripts/bash"
fish_add_path "$HOME/scripts/python"
fish_add_path "$HOME/scripts/c"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.config/emacs/bin"
fish_add_path "/usr/bin/flutter/bin"
fish_add_path "$HOME/.neva/bin"

set fish_color_normal brcyan
set fish_color_autosuggestion brgrey
set fish_color_command green # '#50fa7b'
set fish_color_error red #'#ff5555'
set fish_color_quote bryellow

fish_vi_key_bindings


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

alias mirror="sudo reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist"
alias ll='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ls='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | grep -E "^\."'
alias vim='nvim'
alias bstart='startx /usr/bin/bspwm'
alias openstart='startx /usr/bin/openbox-session'
alias dstart='startx /usr/local/bin/dwm'
# alias compdir='sshfs mr_robot@192.168.1.20:/home/mr_robot ~/sshfs'
# alias sushi="ssh sushi@43.231.56.189 -p 8224"
# alias sushifs="sshfs sushi@43.231.56.189:/home/sushi/ sshfs/ -p 8224"
# alias gentup="sudo emerge -avuDN --with-bdeps y @world"
# alias remerge="sudo emerge -ca"
# alias clean="sudo eclean-dist -d && sudo revdep-rebuild"
alias rclear='echo -en "\x1b[2J\x1b[1;1H" ; echo; echo; seq 1 (tput cols) | sort -R | sparklines | lolcat; echo; echo'
alias pipes="pipes-rs -k curved -p 3 -t 0.13 -r 0.6"
alias ":q"="exit"
alias nosleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias yesleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias bsdk="lsblk"
# alias up="paru -Syu --sudoloop"
alias up="sudo nixos-rebuild switch --flake .#cafo --upgrade"
alias reb="sudo nixos-rebuild switch --flake .#cafo"
alias it="paru -S --sudoloop"
alias v="vim"
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
any-nix-shell fish --info-right | source
# rxfetch
