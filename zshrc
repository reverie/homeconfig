export EDITOR=vim
export SVN_EDITOR=vim
alias c="git checkout";
alias b="git branch";
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
alias gpickaxe="git log -p -S"
alias gcleanup="c master && gp && delete-merged-local-branches && git remote prune origin && delete-merged-remote-branches"

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

NEWLINE=$'\n'
export PROMPT="${NEWLINE}%F{yellow}%n@%m%F{white} %~${NEWLINE}: "

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

# Homebrew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# enable the default zsh completions!
autoload -Uz compinit && compinit

