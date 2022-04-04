# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


# History control
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias grep='grep --color=auto'
alias gg='git grep -ni'
alias phpunit='phpunit --colors'
alias vimpress="VIMENV=talk vim"
alias c="composer"
alias v="vagrant"
alias d="sudo docker"
alias biggest="du -h --max-depth=1 | sort -h"
alias tnn="cd ~/src/github.com/tomnomnom"
alias :q="exit"
alias norg="gron --ungron"
alias ungron="gron --ungron"
alias j="jobs"
alias follow="tail -f -n +1"

# COLOURS! YAAAY!
export TERM=xterm-256color

# Obviously.
export EDITOR=/usr/bin/vim

# Personal binaries
export PATH=${PATH}:~/bin:~/.local/bin:~/etc/scripts

# I'd quite like for Go to work please.
export PATH=${PATH}:/usr/local/go/bin
export GOPATH=~


# Change up a variable number of directories
# E.g:
#   cu   -> cd ../
#   cu 2 -> cd ../../
#   cu 3 -> cd ../../../
function cu {
    local count=$1
    if [ -z "${count}" ]; then
        count=1
    fi
    local path=""
    for i in $(seq 1 ${count}); do
        path="${path}../"
    done
    cd $path
}


# Open all modified files in vim tabs
function vimod {
    vim -p $(git status -suall | awk '{print $2}')
}

# Open files modified in a git commit in vim tabs; defaults to HEAD. Pop it in your .bashrc
# Examples: 
#     virev 49808d5
#     virev HEAD~3
function virev {
    commit=$1
    if [ -z "${commit}" ]; then
      commit="HEAD"
    fi
    rootdir=$(git rev-parse --show-toplevel)
    sourceFiles=$(git show --name-only --pretty="format:" ${commit} | grep -v '^$')
    toOpen=""
    for file in ${sourceFiles}; do
      file="${rootdir}/${file}"
      if [ -e "${file}" ]; then
        toOpen="${toOpen} ${file}"
      fi
    done
    if [ -z "${toOpen}" ]; then
      echo "No files were modified in ${commit}"
      return 1
    fi
    vim -p ${toOpen}
}

# 'Safe' version of __git_ps1 to avoid errors on systems that don't have it
function gitPrompt {
  command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
}

# Colours have names too. Stolen from Arch wiki
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Prompt colours
atC="${txtpur}"
nameC="${txtpur}"
hostC="${txtpur}"
pathC="${txtgrn}"
gitC="${txtpur}"
pointerC="${txtgrn}"
normalC="${txtwht}"

# Red name for root
if [ "${UID}" -eq "0" ]; then 
  nameC="${txtred}" 
fi

# Patent Pending Prompt
export PS1="${nameC}\u${atC}@${hostC}\h:${pathC}\w${gitC}\$(gitPrompt)${pointerC}▶${normalC} "

# Local settings go last
if [ -f ~/.localrc ]; then 
  source ~/.localrc
fi
