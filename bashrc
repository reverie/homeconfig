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

export EDITOR=vim
function c { git checkout $@; }
function b { git branch $@; }
alias j="cd .."
alias s="git status"
alias d="git diff"
alias dc="git diff --cached"
alias dv="git diff | vim -"
alias l="git log"
alias gp="git pull"
alias gpu="git push"
alias cam="git commit -am"
alias delete-merged-local-branches="git branch --merged | grep -v master | grep -v staging | xargs git branch -d"
alias delete-merged-remote-branches="git branch -r --merged | grep -v master | grep -v staging | grep origin | sed 's/origin\///' | xargs -n 1 git push --delete origin"
function delete-branches-matching { git branch | grep "$@" | xargs git branch -D; }
alias gpickaxe="git log -p -S"
alias gcleanup="c master && gp && delete-merged-local-branches && git remote prune origin && delete-merged-remote-branches"
alias vmwaresucks='sudo "/Library/Application Support/VMware Fusion/boot.sh" --restart'
alias virtualboxsucks='sudo /Library/StartupItems/VirtualBox/VirtualBox restart'
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

if command -v ack > /dev/null; then
    :
else
    alias ack="ack-grep"
fi

# Get/set default working directory
alias setd='echo `pwd` > ~/.bash_dir'
alias getd='cd "`cat ~/.bash_dir`"'
if [ -s ~/.bash_dir ]; then
    getd
fi

# Get/set default virutalenv
alias setve='echo $VIRTUAL_ENV | xargs > ~/.bash_ve' # xargs trims whitespace :}
alias getve='source `cat ~/.bash_ve`/bin/activate'

export PS1="\n\[\033[35m\]\[\033[33m\]\u@\h \[\033[0m\]\w\n\[\033[35m\]\[\033[0m\]: "
alias runserver="./manage.py runserver 0.0.0.0:8000"
export WORKON_HOME="$HOME/envs"
export PIP_RESPECT_VIRTUALENV=true

alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
export PATH=$PATH:~/cmds:~/bin:~/.local/bin
# killgrep ps aux | grep fcgi | grep -v grep | awk '{print $2}' | xargs kill

# Find and replace: TODO make fxn
#perl -e "s/FIND/REPLACE/g;" -pi $(find path/to/DIRECTORY -type f)
# grep -rl 'FIND' ./ | LANG=C xargs sed -i '' 's/FIND/REPLACE/g'
# you can also use `ack -l`

# Do something (ls) in every directory:
# find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && ls" \;


alias push="git push && git push heroku master && heroku run ./manage.py migrate"
alias lsd="ls -d  .*/ */"
alias push-to-staging="git push -f origin HEAD:staging"


# From https://stackoverflow.com/a/41598648/
function pip-save() {
    for pkg in $@; do
        pip install "$pkg" && {
            name="$(pip show "$pkg" | grep Name: | awk '{print $2}')";
            version="$(pip show "$pkg" | grep Version: | awk '{print $2}')";
            echo "${name}==${version}" >> requirements.txt;
        }
    done
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/andrew/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;


if [ -f ~/.local_bashrc ]; then
    source ~/.local_bashrc
fi
