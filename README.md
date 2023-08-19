Taken from tutorial: https://www.atlassian.com/git/tutorials/dotfiles

## Setup

Clone the repository, set an alias and configure git not to show untracked files:

```bash
git clone git@github.com:AlexTuft/dotfiles.git $HOME/.dotfiles --bare
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```
