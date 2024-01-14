parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\e[1;32m\u@\h \e[1;34m\w \e[1;36m\$(parse_git_branch)\e[00m$ "
