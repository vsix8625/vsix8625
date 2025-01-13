# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything

case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
 
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

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
clr16='\033[40;5;16m\]'
clr17='\033[41;5;17m\]'
clr18='\033[42;5;18m\]'
clr19='\033[43;5;19m\]'
clr20='\033[44;5;20m\]'

circle_green="\U1f7e2"
circle_red="\U1f534"
exit_status=" "

update_ps1(){
  if [[ ! $? -eq 0 ]]; then
    exit_status="$circle_red "
  else
    exit_status="$circle_green "
  fi
  PS1="\n$clr8$(printf "\U250f\U2501")$reset[$clr11\u$clr4@$clr3\h$reset]: $clr8\w $clr8\n$(printf "\U2517\U2501>$reset $exit_status")"
}

if [ "$color_prompt" = yes ]; then
    #PS1='\[\033[38;5;03m\]\s:${debian_chroot:+($debian_chroot)}\[\033[38;5;11m\]\u\[\033[38;5;02m\]@\h\[\033[16m\]:\[\033[38;5;03m\]\w\[\033[0m\] \$ '
    PS1="\n$(printf "\U250f\U2501")$clr11[\u$clr16@$clr6\h]: $clr3\w $reset\n$(printf "\U2517\U2501> " )"
else
    PS1='${debian_chroot:+($debian_chroot)}[\033[38;5;01m\]\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export LS_COLORS="di=01;33:fi=32:ln=36:ex=1;31;40:*.jpg=35:*.png=35"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

export EDITOR=nvim
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#---------------------------------------------------------------------------------------------------- 

extr(){
 local argc="$1"
 if [ -f $argc ]; then
   case $argc in 
     *.tar.bz2)    tar xjf    $argc ;;
     *.tar.gz)     tar xzf    $argc ;;
     *.bz2)        bunzip2    $argc ;;
     *.rar)        unrar x    $argc ;;
     *.zip)        unzip      $argc ;;
     *.Z)          uncompress $argc ;;
     *.7z)         7z x       $argc ;;
     *.deb)        ar x       $argc ;;
     *.tar.xz)     tar xf     $argc ;;
     *.tar.zst)    unzstd     $argc ;;
     *)            printf     "'$argc' cannot be extracted by extr()\n" ;;
   esac
 else 
   printf "$argc is not a vaild command\n"
 fi
}

#---------------------------------------------------------------------------------------------------- 

PROMPT_COMMAND='update_ps1'

source "$HOME/.local_bash.sh"

