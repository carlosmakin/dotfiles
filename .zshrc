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

# Alias common commands
alias diff='diff --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls --color=auto'
alias ping='ping -c 5'
alias rmdir='rm -rf'
alias cp='cp -v'
alias ln='ln -v'
alias mv='mv -v'
alias rm='rm -v'

# Set options
setopt PROMPT_SUBST

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

# PATH Configuration
export PATH="$PATH:/usr/local/flutter/bin"
export PATH="$PATH:/usr/local/go/bin/go"

# Homebrew Integration
eval "$(/opt/homebrew/bin/brew shellenv)"

# Syntax highlighting and auto-suggestions
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
