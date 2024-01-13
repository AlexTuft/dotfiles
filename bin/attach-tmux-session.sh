#!/bin/bash

if [ ! -z "$TMUX" ]; then
    exit 0 # Dont run tmux in tmux
fi

session_name=$(tmux ls | awk -F: '{print $1}' | fzf)

if [ -z "$session_name" ]; then
    exit 0
fi

tmux attach-session -t $session_name

