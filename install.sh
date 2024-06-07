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

# Prompt to install Homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
    read -p "Homebrew is not installed. Do you want to install it? (y/n) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    if ! brew list zsh-syntax-highlighting &>/dev/null; then
        read -p "zsh-syntax-highlighting is not installed. Do you want to install it? (y/n) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install zsh-syntax-highlighting
        fi
    fi

    if ! brew list zsh-autosuggestions &>/dev/null; then
        read -p "zsh-autosuggestions is not installed. Do you want to install it? (y/n) " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install zsh-autosuggestions
        fi
    fi

    # Add Homebrew integration to .zshrc if not already present
    if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.dotfiles/.zshrc"; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.dotfiles/.zshrc"
    fi

    # Add zsh-syntax-highlighting to .zshrc if installed and not already present
    ZSH_SYNTAX_HIGHLIGHTING="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    if [ -f "$ZSH_SYNTAX_HIGHLIGHTING" ] && ! grep -q "source $ZSH_SYNTAX_HIGHLIGHTING" "$HOME/.dotfiles/.zshrc"; then
        echo "source $ZSH_SYNTAX_HIGHLIGHTING" >> "$HOME/.dotfiles/.zshrc"
    fi

    # Add zsh-autosuggestions to .zshrc if installed and not already present
    ZSH_AUTOSUGGESTIONS="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    if [ -f "$ZSH_AUTOSUGGESTIONS" ] && ! grep -q "source $ZSH_AUTOSUGGESTIONS" "$HOME/.dotfiles/.zshrc"; then
        echo "source $ZSH_AUTOSUGGESTIONS" >> "$HOME/.dotfiles/.zshrc"
    fi
fi

# Create a symbolic link from .dotfiles/.zshrc to ~/.zshrc
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

# Reload zsh configuration
echo "Installation complete! Reloading .zshrc..."
source "$HOME/.zshrc"

echo "All set! Your new zsh configuration is now active."