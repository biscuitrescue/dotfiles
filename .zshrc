export EDITOR="emacsclient -ca ''"
export MANPAGER="nvim +Man!"
export TERM="xterm-256color"
export COLORTERM="truecolor"
# FZF
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 4
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/cafo/.zshrc'

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1100000000
SAVEHIST=1000000000

# OPTS
setopt autocd extendedglob nomatch notify always_to_end auto_menu auto_pushd complete_in_word 
setopt hist_ignore_space hist_find_no_dups hist_expire_dups_first interactivecomments 
unsetopt beep flow_control list_beep menu_complete 

bindkey -v

# Alias
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

# eval "$(starship init zsh)"
setopt PROMPT_SUBST
# PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

autoload -Uz vcs_info

# # Enable Git info
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' stagedstr '+'
# zstyle ':vcs_info:*' unstagedstr '!'
# zstyle ':vcs_info:git:*' formats '(%b%u%c%m)'   # %m will be used for untracked indicator
# zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c%m)'
#
# # untracked files
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# zstyle ':vcs_info:git+set-message:*' hooks git-aheadbehind
#
# +vi-git-untracked() {
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#        git status --porcelain | grep '??' &> /dev/null ; then
#         # Show '?' in the misc (%m) section if untracked files exist
#         hook_com[misc]='?'
#     fi
# }
#
# +vi-git-aheadbehind() {
#   local ahead behind
#   ahead=$(git rev-list @{upstream}..HEAD 2>/dev/null | wc -l)
#   if (( ahead > 0 )); then
#     hook_com[misc]='⬆'
#   fi
# }
# # Run vcs_info before every prompt
# precmd() { vcs_info }
# setopt PROMPT_SUBST
#
# PS1='
# %F{blue}%~%f%F{yellow} ${vcs_info_msg_0_}
# %f%(?.%F{green}.%F{red})%f '


autoload -Uz vcs_info

# Enable Git info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b%u%c%m)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c%m)'

# Custom symbols for staged/untracked/unstaged
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '?'
zstyle ':vcs_info:git:*' untrackedstr '!'

# Hook for committed but not pushed
zstyle ':vcs_info:git+set-message:*' hooks git-ahead

function +vi-git-ahead() {
  local ahead
  ahead=$(git rev-list @{upstream}..HEAD 2>/dev/null | wc -l)
  if (( ahead > 0 )); then
    hook_com[misc]='⬆'
  fi
}

# Run vcs_info before every prompt
precmd() { vcs_info }

setopt PROMPT_SUBST

PS1='
%F{blue}%~%f%F{yellow} ${vcs_info_msg_0_}
%f%(?.%F{green}.%F{red})%f '

source <(fzf --zsh)
