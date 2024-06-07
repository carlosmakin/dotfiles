#!/bin/bash

# Create .dotfiles directory if it does not exist
mkdir -p "$HOME/.dotfiles"

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up current .zshrc to .zshrc.bak"
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    rm "$HOME/.zshrc"
fi

# Write the new .zshrc configuration to .dotfiles directory
cat << 'EOF' > "$HOME/.dotfiles/.zshrc"
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
setopt CORRECT
setopt PROMPT_SUBST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

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
alias ping='ping -c 5'
alias df='df -h'
alias du='du -h'
alias cp='cp -v'
alias ln='ln -v'
alias mv='mv -v'
alias rm='rm -v'

EOF

# Create a symbolic link from .dotfiles/.zshrc to ~/.zshrc
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

# Reload zsh configuration
echo "Installation complete! Please reload .zshrc"