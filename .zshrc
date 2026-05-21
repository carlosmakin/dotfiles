# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit vcs_info
compinit

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

# Shell behavior
setopt AUTO_CD
setopt PROMPT_SUBST
setopt EXTENDED_GLOB

# Git branch in prompt
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{green}*%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%f%F{red}%b%f%F{blue})%f%u%c'

precmd() {
  vcs_info
}

# Prompt
PROMPT='%F{%(?.green.red)}%(?.➜.✗)%f %F{cyan}%c%f${vcs_info_msg_0_} '
RPROMPT='%@'

# History search with arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
export CLICOLOR=1
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -aG'
alias ping='ping -c 5'
alias df='df -h'
alias du='du -h'
alias cp='cp -v'
alias ln='ln -v'
alias mv='mv -v'
alias rm='rm -v'

# Plugins
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
