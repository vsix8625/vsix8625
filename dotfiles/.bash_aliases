
alias sobrc="source ~/.bashrc"
# Make sure to export your editor to .bashrc
# Edit bashrc
alias ebrc="$EDITOR ~/.bashrc"
# Edit bash_aliases
alias ebal="$EDITOR ~/.bash_aliases"
alias elbsh="$EDITOR ~/.local_bash"
alias egit="$EDITOR ~/.gitconfig"

alias grt="cd /"
alias gho="cd "

alias v="nvim"
alias vdbg="nvim --cmd \"lua vim.g.debug_mode = 1\""
alias gvim="cd $HOME/.config/nvim"

# checks build for Makefile
alias makeb="make -C build"
alias make-clean="make -C build clean"
# Creates a simple Makefile in build dir.
alias mkm="MakeMagic"
# Makefile created by MakeMagic, it will also create the
# config/app.conf file, its just the name of the bin created by make,
# then we can use rapp alias to run the binary.
alias rapp="\$(< config/app.conf)"

# opens editor with sudo 
alias sudovi="sudo -E $EDITOR"

# Git
alias g="git"
alias gconf="git config --list"
alias gstat="git diff --stat"
alias gaddv="git status && git add -A && git status"

alias cid="ls -1 | wc -l"
alias cidf="find . -type f | wc -l"
# 
alias cls="clear && echo && ls"

alias df="df -h"      #  -h human readable flag
alias free="free -m"  # shows in MB

alias sapt="sudo apt"
alias sapt-update="gnome-terminal --window-with-profile=gnome --geometry=80x30+1800+800 -- bash -c 'sudo apt update && sudo apt upgrade -y; exec bash'"
alias sapt-clean="gnome-terminal --window-with-profile=gnome --geometry=80x30+1800+800 -- bash -c 'sudo apt autoremove && sudo apt autoclean && sudo apt autopurge;'"

alias ss="sudo systemctl"
alias ssfail="sudo systemctl | grep 'failed'"
alias fzman="compgen -c | fzf | xargs man"

#---------------------------------------------------------------------------------------------------- 
# Some "fun" shortcuts

alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."

alias :q="exit"
alias hdsize="du -sh ."
 
# pictures in terminal
alias icat="kitten icat"

alias tm="date"

# History logs of package manager updates and removals
alias aptlog="cat /var/log/apt/history.log | fzf"
alias aptlogs="cat /var/log/apt/history.log | less -R"

#---------------------------------------------------------------------------------------------------- 
# GNOME terminal 

alias hobbit="gnome-terminal --window-with-profile=gnome --geometry=100x70+1870+10 -- "
alias htop="gnome-terminal --window-with-profile=gnome --geometry=100x50+1870+10 -- bash -c 'htop; exec bash'"

alias neof="gnome-terminal --window-with-profile=vsix --geometry=80x30+1800+800 -- bash -c 'neofetch; exec bash'"
alias matrix="gnome-terminal --window-with-profile=matrix --full-screen -- bash -c 'cmatrix -C green'"

#---------------------------------------------------------------------------------------------------- 

source "$HOME/.usr_aliases"
