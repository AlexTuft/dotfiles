# Create different history file for each tmux session
mkdir -p "$HOME/.bash-history"

if [[ $TMUX_PANE ]]; then
    session_name=$(tmux display-message -p '#S')
    HISTFILE=$HOME/.bash-history/tmux_$session_name
fi
