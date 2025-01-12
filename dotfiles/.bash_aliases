
alias sobrc="source ~/.bashrc"
# Make sure to export your editor to .bashrc
alias ebrc="$EDITOR ~/.bashrc"
alias ebal="$EDITOR ~/.bash_aliases"

alias grt="cd /"
alias gho="cd "

alias v="nvim"
alias gvim="cd $HOME/.config/nvim"
alias gvim-colors="cd /usr/local/share/nvim/runtime/colors"

alias gpro="cd $HOME/Projects"
alias gspro="cd $HOME/SDL_Projects"
alias gbin="cd $HOME/.scripts/bin"

alias sudovi="sudo -E $EDITOR"

alias ibx="IronbinX"
alias g="git"

alias cid="ls -1 | wc -l"
alias cidf="find . -type f | wc -l"
alias cls="clear && echo && ls"

#---------------------------------------------------------------------------------------------------- 
# Custom discontinued library
# Will be removed
alias acelude="cd /usr/local/include/ACE"
alias acesrc="cd /usr/local/src/ACE"
alias acelib="cd /usr/local/lib"

#---------------------------------------------------------------------------------------------------- 

alias nmrestart="gnome-terminal --window-with-profile=gnome --geometry=30x30+1800+800 -- bash -c 'sudo systemctl restart NetworkManager && ping 8.8.8.8; exec bash'"

alias df="df -h"      #  -h human readable flag
alias free="free -m"  # shows in MB

alias sapt="sudo apt"
alias sapt-update="gnome-terminal --window-with-profile=gnome --geometry=80x30+1800+800 -- bash -c 'sudo apt update && sudo apt upgrade -y; exec bash'"
alias sapt-clean="gnome-terminal --window-with-profile=gnome --geometry=80x30+1800+800 -- bash -c 'sudo apt autoremove && sudo apt autoclean && sudo apt autopurge;'"

alias ss="sudo systemctl"
alias ssfail="sudo systemctl | grep 'failed'"
alias fzman="compgen -c | fzf | xargs man"

# Aliases for custom bash script executables
alias ib="IronBin"
alias smake="Sythium_Make"
alias md="MusicDownload"
alias drc="DirCrawler"
alias obl="Obliterate"
alias neof="gnome-terminal --window-with-profile=vsix --geometry=80x30+1800+800 -- bash -c 'neofetch; exec bash'"
alias f="blink"

#---------------------------------------------------------------------------------------------------- 
# Some "fun" shortcuts

alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."

alias :q="exit"
alias :gnight="shutdown -h now"
 
# pictures in terminal
alias icat="kitten icat"

alias tm="date"

alias aptlog="cat /var/log/apt/history.log | fzf"
alias aptlogs="cat /var/log/apt/history.log | less -R"

#---------------------------------------------------------------------------------------------------- 
# GNOME terminal 

alias hobbit="gnome-terminal --window-with-profile=gnome --geometry=100x70+1870+10 -- "
alias htop="gnome-terminal --window-with-profile=gnome --geometry=100x50+1870+10 -- bash -c 'htop; exec bash'"

alias matrix="gnome-terminal --window-with-profile=matrix --full-screen -- bash -c 'cmatrix -C green'"

#---------------------------------------------------------------------------------------------------- 


