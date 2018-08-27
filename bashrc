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

export PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '
export EDITOR=vim
export SVN_EDITOR=vim
function c { git checkout $@; }
function b { git branch $@; }
function f { ack -a -l $@ | ack -v migrations | ack -v .sqlite; }
alias ackk="ack --coffee"
alias j="cd .."
alias s="git status"
alias d="git diff"
alias dc="git diff --cached"
alias dv="git diff | vim -"
alias l="git log"
alias gp="git pull --rebase"
alias gpu="git push"
alias gpgpu="git pull --rebase && git push"
alias cam="git commit -am"
alias aa="git add -A :/"
alias vmwaresucks='sudo "/Library/Application Support/VMware Fusion/boot.sh" --restart'
alias virtualboxsucks='sudo /Library/StartupItems/VirtualBox/VirtualBox restart'
alias i='mosh ianab'
alias dokku='mosh dokku'
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

if command -v ack > /dev/null; then
    :
else
    alias ack="ack-grep"
fi

# Get/set default working directory
alias setd='echo `pwd` > ~/.bash_dir'
alias getd='cd `cat ~/.bash_dir`'
if [ -f ~/.bash_dir ]; then
    getd
fi

# Get/set default virutalenv
alias setve='echo $VIRTUAL_ENV > ~/.bash_ve'
alias getve='source `cat ~/.bash_ve`/bin/activate'

export PS1="\n\[\033[35m\]\[\033[33m\]\u@\h \[\033[0m\]\w\n\[\033[35m\]\[\033[0m\]: "
alias runserver="./manage.py runserver 0.0.0.0:8000"
export WORKON_HOME="$HOME/envs"
export PIP_RESPECT_VIRTUALENV=true

alias deploy="fab deploy"
alias testm="./manage.py test main"
alias south_sm="./manage.py schemamigration main --auto"
function south_sm { ./manage.py schemamigration $1 --auto; }
alias south_m="./manage.py migrate"
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
export PATH=$PATH:~/cmds:~/bin:~/.local/bin
#alias setpp="export PYTHONPATH=$PYTHONPATH:`pwd`:.."
# killgrep ps aux | grep fcgi | grep -v grep | awk '{print $2}' | xargs kill
alias init="touch __init__.py"

# Find and replace: TODO make fxn
#perl -e "s/FIND/REPLACE/g;" -pi $(find path/to/DIRECTORY -type f)

if [ -f ~/.local_bashrc ]; then
    source ~/.local_bashrc
fi

alias push="git push && git push heroku master && heroku run ./manage.py migrate"
alias lsd="ls -d  .*/ */"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
