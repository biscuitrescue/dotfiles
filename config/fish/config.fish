set -x EDITOR "nvim"
set -x BAT_THEME "ansi"
set fish_greeting
set -x RANGER_LOAD_DEFAULT_RC "FALSE"
# set TERM "alacritty"
set TERM "xterm-256color"
set COLORTERM "truecolor"
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

# zoxide
# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    if set -q __zoxide_loop
        builtin echo "zoxide: infinite loop detected"
        builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
        return 1
    end
    __zoxide_loop=1 __zoxide_cd_internal $argv
end

# Hook configuration for zoxide.
# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end
# When using zoxide with --no-cmd, alias these internal functions as desired.
# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi


alias vim='nvim'
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
alias gentup="sudo emerge -avuDN --with-bdeps y @world"
alias remerge="sudo emerge -ca"
alias clean="sudo eclean-dist -d && sudo revdep-rebuild"
# Arch
# alias up="paru -Syu --sudoloop"
alias mirror="sudo reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist"
alias nosleep="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias yesleep="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"
# NixOS
alias ns="nix-shell"
alias ncg="nix-collect-garbage --delete-older-than 1d"
alias up="sudo nixos-rebuild switch --flake .#cafo --upgrade-all"
alias reb="sudo nixos-rebuild switch --flake .#cafo"
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
any-nix-shell fish --info-right | source
zoxide init fish | source
