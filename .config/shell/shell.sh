if [ ! -z $ZSH ]; then
    source ~/.config/shell/aliases.sh
    source ~/.config/shell/bindings_zsh.sh
    source ~/.config/shell/history.sh
else
    source ~/.config/shell/aliases.sh
    source ~/.config/shell/bindings.sh
    source ~/.config/shell/history.sh
    source ~/.config/shell/prompt.sh
fi
