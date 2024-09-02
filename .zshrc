# Enable completion
autoload -Uz compinit
compinit

# Enable case-insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Set case sensitivity for autocompletion to false (may not be necessary)
CASE_SENSITIVE="false"

# Makes color constants available
autoload -U colors
colors

# Enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Set options
setopt AUTO_CD
setopt CORRECT
setopt PROMPT_SUBST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_GLOB

# VCS info (Git branch)
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}*%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%f%F{red}%b%f%F{blue})%f%u%c'
precmd() { vcs_info }

# Prompt Customization
PROMPT='%F{%(?.green.red)}%(?.➜.✗)%f %F{cyan}%c%f${vcs_info_msg_0_} ' 
RPROMPT="%@"

# History Search with Arrow Keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Alias common commands
alias diff='diff --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias ping='ping -c 5'
alias df='df -h'
alias du='du -h'
alias cp='cp -v'
alias ln='ln -v'
alias mv='mv -v'
alias rm='rm -v'

# Homebrew Integration
eval "$(/opt/homebrew/bin/brew shellenv)"

# Syntax highlighting and auto-suggestions
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Command-line fuzzy finder
source <(fzf --zsh)
