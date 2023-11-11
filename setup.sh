#!/usr/bin/env bash

set -e

# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "tmux plugin manager already found. Skipping"
fi

# lint tmux config
if [ -f ~/.tmux.conf ]; then
    echo "tmux config already present, Do you want to replace? (y/N): "
    read -n1 response
    echo ""
    if [[ $response =~ ^[Yy]$ ]]; then
        echo "Backing up existing tmux config to ~/.tmux.conf.bak"
        mv ~/.tmux.conf ~/.tmux.conf.bak 
        cp $(pwd)/.tmux.conf ~/.tmux.conf
    else
        echo "Skipping tmux config setup"
        exit 0
    fi
fi

# replace shell path in tmux config
SHELL_PATH=$(which zsh)
echo "Setting tmux shell path to $SHELL_PATH"
sed -i '' "s,SHELL_PATH,$SHELL_PATH,1" ~/.tmux.conf # The extra '' needed for BSD sed on mac

# launch tmux for plugin installation
tmux source ~/.tmux.conf
