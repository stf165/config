set fish_greeting ""

alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias g git
alias e vim
alias t tmux
alias mp ncmpcpp
alias fm ranger

set -gx EDITOR vim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH
