#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

reset='\033[0m\]'
clr1='\033[38;5;01m\]'
clr2='\033[38;5;02m\]'
clr3='\033[38;5;03m\]'
clr4='\033[38;5;04m\]'
clr5='\033[38;5;05m\]'
clr6='\033[38;5;06m\]'
clr7='\033[38;5;07m\]'
clr8='\033[38;5;08m\]'
clr9='\033[38;5;09m\]'
clr10='\033[38;5;10m\]'
clr11='\033[38;5;11m\]'
clr12='\033[38;5;12m\]'
clr13='\033[38;5;13m\]'
clr14='\033[38;5;14m\]'
clr15='\033[38;5;15m\]'
clr16='\033[38;5;16m\]'
clr17='\033[38;5;17m\]'
clr18='\033[38;5;18m\]'
clr19='\033[38;5;19m\]'
clr20='\033[38;5;20m\]'
clr23='\033[38;5;23m\]'
clr28='\033[38;5;28m\]'
clr49='\033[38;5;49m\]'
clr52='\033[38;5;52m\]'
clr130='\033[38;5;130m\]'
clr131='\033[38;5;131m\]'

PS1="\n$clr130[\u$clr23@$clr12\h]: $clr52\w $reset\n$(printf "$ " )"
#PS1='[\u@\h \W]\$ '

export TERM=xterm-256color

export GCC_COLORS='error=38;5;88:warning=38;5;172:note=38;5;22:caret=01;32:locus=01:quote=01'
export LS_COLORS="di=38;5;202:fi=38;5;101:ln=38;5;226:pi=38;5;52:ex=38;5;124:so=1;35:cd=1;33;41:*.jpg=35:*.png=35:*.c=38;5;31:*.h=38;5;22"
export EDITOR=nvim 
export DEVENV="/devenv"

case ":$PATH:" in
  *":$DEVENV/usr/bin:"*) ;;
  *) PATH="$PATH:$DEVENV/usr/bin" ;;
esac

case ":$PATH:" in
  *":$HOME/usr/bin:"*) ;;
  *) PATH="$PATH:$HOME/usr/bin" ;;
esac

export PATH

source "$HOME/.aliases"

