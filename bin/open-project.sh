#!/bin/bash

work_dir=~/sources/

workspace_dir=$(find $work_dir -maxdepth 1 -type d | fzf)

session_name=$(basename $workspace_dir)
tmux new-session -A -s $session_name -c $workspace_dir

