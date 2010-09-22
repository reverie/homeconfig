# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

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
#force_colored_prompt=yes

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
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
function c { git checkout $@; }
function b { git branch $@; }
export SVN_EDITOR=vim
#export DJANGO_SETTINGS_MODULE=disqus.settings
#export PYTHONPATH=/Users/andrewbadr/Desktop/disqus/trunk/
#function mfb { svn merge -c $2 /Users/andrewbadr/Desktop/disqus/branches/$1; }
#alias branchdiff="svn diff http://mass.disqus.net/svn/disqus/branches/stable/ http://mass.disqus.net/svn/disqus/trunk/"
alias setpp="export PYTHONPATH=`pwd`:`pwd`/django_root"
#alias svnup="svn up /Users/andrewbadr/Desktop/disqus"
#alias trunk="cd /Users/andrewbadr/Desktop/disqus/trunk/disqus"
#alias stable="cd /Users/andrewbadr/Desktop/disqus/branches/stable/disqus"
alias .="cd .."
alias s="git status"
alias d="git diff"
alias dv="git diff | vim -"
alias build="ssh build@mass.disqus.net"
alias restart='sudo apache2ctl restart'
alias apacheconf='sudo vim /etc/apache2/sites-enabled/ianab'
#function getpo { 
#    trunk; 
#    cd locale/$1/LC_MESSAGES;
#    scp andrew@nova.disqus.net:/www/disqus.com/current/disqus/locale/$1/LC_MESSAGES/django.po .;
#}
alias vmwaresucks='sudo "/Library/Application Support/VMware Fusion/boot.sh" --restart'
#export PATH=$PATH:/Users/andrewbadr/django/django_svn_trunk/django/bin
alias i='ssh ianab'
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export DJANGO_SETTINGS_MODULE=settings
alias triggit="ssh -p 30576 andrew@a.triggit.com"

if command -v ack > /dev/null; then
    :
else
    alias ack="ack-grep"
fi

function ve { source ~/envs/$1/bin/activate; }
#function cd { echo `which cd` $@; echo `pwd` > ~/.bash_dir; }
alias setd='echo `pwd` > ~/.bash_dir'
alias getd='cd `cat ~/.bash_dir`'
if [ -f ~/.bash_dir ]; then
    getd
fi

if [ -f ~/.local_bashrc ]; then
    source ~/.local_bashrc
fi

function fbcssh { ssh -i ~/aws/flybychat-west.pem ubuntu@$1; }
function fbcfab { fab -i ~/aws/flybychat-west.pem -u ubuntu -H $1 ${@:2}; }
alias fabproddep1="fab -i ~/aws/flybychat-west.pem stage_production all_hosts deploy_prep_new_release"
function fabproddep2 { fab -i ~/aws/flybychat-west.pem stage_production all_hosts deploy_activate_release:$1; }
function fabdep1 { fab -i ~/aws/flybychat-west.pem stage_$1 all_hosts deploy_prep_new_release; }
function fabdep2 { fab -i ~/aws/flybychat-west.pem stage_$1 all_hosts deploy_activate_release:$2; }

# malcolmt's prompt
e=\\\033
#export PS1="\n\[$e[35m\].-(\[$e[33m\]\u@\h \[$e[36m\]\t\[$e[35m\])\[$e[0m\]\w\n\[$e[35m\]\\\`-->\[$e[0m\] "
export PS1="\n\[\033[35m\]\[\033[33m\]\u@\h \[\033[0m\]\w\n\[\033[35m\]\[\033[0m\]: "

alias runserver="python manage.py runserver 0.0.0.0:8000"
