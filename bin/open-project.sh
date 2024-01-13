#!/bin/bash

if [ ! -z "$TMUX" ]; then
    exit 0
fi

work_dir=~/sources/

workspace_dir=$(find $work_dir -maxdepth 1 -type d | fzf)

if [ -z "$workspace_dir" ]; then
    exit 0
fi

session_name=$(basename $workspace_dir)
tmux new-session -A -s $session_name -c $workspace_dir

