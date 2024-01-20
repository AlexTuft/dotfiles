#!/bin/bash

if [ ! -z "$TMUX" ]; then
    exit 0
fi

work_dirs=~/sources
if [ ! -z $WORK_DIRS ]; then
    work_dirs=$WORK_DIRS
fi

workspace_dir=$(find $(echo $work_dirs | tr ":" " ") -maxdepth 1 -type d | fzf)

if [ -z "$workspace_dir" ]; then
    exit 0
fi

session_name=$(basename $workspace_dir)
tmux new-session -A -s $session_name -c $workspace_dir

