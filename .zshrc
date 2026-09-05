export EDITOR="emacsclient -ca ''"
export MANPAGER="nvim +Man!"
export TERM="xterm-256color"
export COLORTERM="truecolor"
# FZF
export FZF_DEFAULT_OPTS='
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

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 4
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/cafo/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1100000000
SAVEHIST=1000000000

# OPTS
setopt autocd extendedglob nomatch notify always_to_end auto_menu auto_pushd complete_in_word
setopt hist_ignore_space hist_find_no_dups hist_expire_dups_first interactivecomments
setopt share_history inc_append_history
unsetopt beep flow_control list_beep menu_complete

bindkey -e
bindkey "^[[1;3C" forward-word  # Alt + Right Arrow
bindkey "^[[1;3D" backward-word # Alt + Left Arrow
bindkey "\e[f" forward-word     # Alt + F
bindkey "\e[b" backward-word    # Alt + B
bindkey '^E' end-of-line                     # Ctrl+E accepts the whole suggestion and moves to end
bindkey '^F' forward-char                    # Ctrl+F accepts one character of the suggestion
bindkey '\e[f' forward-word                  # Alt+F accepts one word of the suggestion

# Zplug
source ~/.zplug/init.zsh

# Plugins
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Bootstrap
zplug "~/.zsh", from:local
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# Autosuggestions Settings
bindkey '^f' forward-word
bindkey '^ ' forward-to-word
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Syntax Highlighting Settings
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,underline'

# Alias
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias wcc="warp-cli connect"
alias wdd="warp-cli disconnect"

alias vim="nvim"
alias v="nvim"

alias ":q"="exit"
### GIT
alias "clone"="git clone"
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
# Eza
alias ll='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ls='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | grep -E "^\."'
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

any-nix-shell zsh --info-right | source /dev/stdin

source <(fzf --zsh)
eval "$(starship init zsh)"
