#!/bin/bash

echo "Updating apt packages..."

if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."    
    sudo apt install -y zsh
fi

if [ ! -d "./.oh-my-zsh" ]; then
    echo "Installing OhMyZsh..."    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."    
    sudo apt install -y tmux
fi

if ! command -v nvim &> /dev/null; then
    echo "Installing Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz

    sudo mkdir -p /opt/nvim &> /dev/null
    sudo tar -zxf nvim-linux64.tar.gz -C /opt/nvim
    rm nvim-linux64.tar.gz
    
    sudo ln -s /opt/nvim/nvim-linux64/bin/nvim /usr/local/bin/nvim
fi

if ! command -v rustup &> /dev/null; then
    echo "Installing rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v go &> /dev/null; then
    echo "Installing go..."
    curl -L https://go.dev/dl/go1.22.8.linux-amd64.tar.gz -o go.tar.gz

    sudo tar -zxf go.tar.gz -C /usr/local
    rm go.tar.gz

    echo 'export PATH=$PATH:/usr/local/go/bin' >> .bashrc
    echo 'export PATH=$PATH:/usr/local/go/bin' >> .zshenv
fi

if ! command -v fzf &> /dev/null; then
    echo "Installing fzf..."    
    sudo apt install -y fzf
fi

